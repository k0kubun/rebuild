require 'rebuild'
require 'fileutils'

module Rebuild
  class Repository
    DEFAULT_DIRECTORY = '/tmp'

    def initialize(path, directory)
      @user, @repo = path.split('/')
      @directory   = directory

      abort "Invalid repository `#{path}`" if @repo.nil?
    end

    def fetch
      if File.exists?(repo_path)
        sync_repository
      else
        clone_repository
      end

      repo_path
    end

    private

    def clone_repository
      FileUtils.mkdir_p(upper_directory)
      `git clone #{github_repository} #{repo_path}`
    end

    def sync_repository
      if dirty_repository?
        puts 'Repository has unstaged changes. Sync skipped.'
      else
        run_with_repository('git pull origin master')
      end
    end

    def dirty_repository?
      run_with_repository('[[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]]')
    end

    def run_with_repository(script)
      system(<<-EOS)
        cd #{repo_path}
        #{script}
      EOS
    end

    def github_repository
      "https://github.com/#{@user}/#{@repo}"
    end

    def repo_path
      File.join(upper_directory, root_directory)
    end

    def root_directory
      if @directory
        @directory.gsub(/\/$/, '').match(/[^\/]+$/).to_s
      else
        @repo
      end
    end

    def upper_directory
      if @directory
        @directory.gsub(/[^\/]+\/?$/, '')
      else
        user_path
      end
    end

    def user_path
      File.join(DEFAULT_DIRECTORY, @user)
    end
  end
end
