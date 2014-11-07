require 'rebuild'
require 'fileutils'

module Rebuild
  class Repository
    def initialize(path, options)
      @user, @repo = path.split('/')
      @directory   = options[:directory]
      @update      = options[:update]

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
      Logger.info("Create repository to #{repo_path}...")
      FileUtils.mkdir_p(upper_directory)
      `git clone #{github_repository} #{repo_path}`
    end

    def sync_repository
      return unless @update

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
      if @directory
        File.expand_path(@directory)
      else
        File.join(default_directory, @repo)
      end
    end

    def upper_directory
      repo_path.gsub(/[^\/]+\/?$/, '')
    end

    def default_directory
      File.expand_path('~')
    end
  end
end
