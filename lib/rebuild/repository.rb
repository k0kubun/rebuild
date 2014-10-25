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
      if File.exists?(repo_path)
        clone_repository
      else
        sync_repository
      end

      repo_path
    end

    private

    def clone_repository
      FileUtils.mkdir_p(user_path)
      `git clone #{github_repository} #{repo_path}`
    end

    def sync_repository
    end

    def github_repository
      "git@github.com:#{@user}/#{@repo}"
    end

    def repo_path
      File.join(user_path, @repo)
    end

    def user_path
      File.join(FETCH_DIRECTORY, @user)
    end
  end
end
