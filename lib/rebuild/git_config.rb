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
          # if true, everytime git pull
          update = false

          # you can change script run directory
          scriptdir = /

          # if present, you can `rebuild` without argument
          # repo = username/dotfiles

          # cloned directory path
          # directory = ~/src/dotfiles
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
        symbolized[key.to_sym] = normalize_value(value)
      end
      symbolized
    end

    # TODO: Migrate from parseconfig
    def normalize_value(value)
      case value
      when 'true'
        true
      when 'false'
        false
      else
        value
      end
    end

    def gitconfig_path
      File.expand_path('~/.gitconfig')
    end
  end
end
