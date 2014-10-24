require 'rebuild'
require 'fileutils'

module Rebuild
  class Repository
    FETCH_REFERENCE = 'master'
    FETCH_DIRECTORY = '/tmp'

    def initialize(path)
      @user, @repo = path.split('/')
      @reference   = FETCH_REFERENCE

      abort "Invalid repository `#{path}`" if @repo.nil?
    end

    def fetch
      FileUtils.mkdir_p(user_path)
      clone_archive

      repo_path
    end

    private

    def clone_archive
      print "Cloning into #{repo_path}..."
      download_archive
      unzip_archive
      FileUtils.rm(archive_path)
      puts " done."
    end

    def download_archive
      `curl -Ls -o #{archive_path} #{archive_url}`
    end

    def unzip_archive
      `unzip -o #{archive_path} -d #{user_path} > /dev/null`
      unzipped_path = File.join(user_path, "#{@repo}-#{@reference}")
      FileUtils.rm_rf(repo_path)
      FileUtils.mv(unzipped_path, repo_path)
    end

    def repo_path
      File.join(user_path, @repo)
    end

    def user_path
      File.join(FETCH_DIRECTORY, @user)
    end

    def archive_path
      File.join(user_path, "#{@repo}.zip")
    end

    def archive_url
      "https://github.com/#{@user}/#{@repo}/archive/#{@reference}.zip"
    end
  end
end
