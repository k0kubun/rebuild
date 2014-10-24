require 'rebuild'

module Rebuild
  FETCH_DIRECTORY = '/tmp'

  class Repository
    def initialize(path)
      @user, @repo = path.split('/')
      abort "Invalid repository `#{path}`" if @repo.nil?
    end

    def fetch
      File.join(FETCH_DIRECTORY, 'dotfiles-master')
    end
  end
end
