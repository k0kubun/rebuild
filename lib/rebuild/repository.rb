require 'rebuild'

module Rebuild
  FETCH_REFERENCE = 'master'
  FETCH_DIRECTORY = '/tmp'

  class Repository
    def initialize(path)
      @user, @repo = path.split('/')
      @reference   = FETCH_REFERENCE

      abort "Invalid repository `#{path}`" if @repo.nil?
    end

    def fetch
      create_userdir
      File.join(FETCH_DIRECTORY, 'dotfiles-master')
    end

    private

    def create_userdir
      puts "Create: #{userdir}"
    end

    def userdir
      File.join(FETCH_DIRECTORY, @user)
    end

    def archive_url
      "https://github.com/#{@user}/#{@repo}/archive/#{@reference}.zip"
    end
  end
end
