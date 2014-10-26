require 'rebuild'
require 'singleton'
require 'parseconfig'

module Rebuild
  class GitConfig
    include Singleton

    def initialize
      return unless File.exists?(gitconfig_path)

      @config = ParseConfig.new(gitconfig_path)
    end

    private

    def gitconfig_path
      File.expand_path('~/.gitconfig')
    end
  end
end
