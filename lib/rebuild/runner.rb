require 'rebuild'

module Rebuild
  class Runner
    def initialize(repo_path, primary_scripts)
      @repo_path       = repo_path
      @primary_scripts = primary_scripts
    end

    def run
      puts "script paths: "
      p script_paths
    end

    private

    def script_paths
      Dir.glob(File.join(@repo_path, '*.sh'))
    end
  end
end
