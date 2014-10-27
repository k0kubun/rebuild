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

    def has_rebuild_config?
      @config.params["rebuild"] != nil
    end

    def add_rebuild_config
      git_config =
        if File.exists?(gitconfig_path)
          File.read(gitconfig_path)
        else
          ''
        end
      rebuild_config = <<-EOS.unindent
        [rebuild]
          update    = false
          scriptdir = /
          directory = #{File.expand_path('~/src/dotfiles')}
      EOS

      File.write(gitconfig_path, "#{git_config}\n#{rebuild_config}")
      Logger.info('Succeed to update ~/.gitconfig')
    end

    def rebuild_config
      symbolize_keys(@config.params["rebuild"] || {})
    end

    private

    def symbolize_keys(hash)
      symbolized = {}

      hash.each do |key, value|
        symbolized[key.to_sym] = value
      end
      symbolized
    end

    def gitconfig_path
      File.expand_path('~/.gitconfig')
    end
  end
end
