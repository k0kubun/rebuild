require 'rebuild'

module Rebuild
  class Runner
    def initialize(repo_path, primary_scripts)
      @repo_path       = repo_path
      @primary_scripts = primary_scripts
    end

    def run
      script_paths.each do |path|
        puts "Running #{path}..."
        `source #{path}`
      end
    end

    private

    def script_paths
      Dir.glob(File.join(@repo_path, '*.sh'))
    end
  end
end
