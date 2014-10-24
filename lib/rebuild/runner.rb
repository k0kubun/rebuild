require 'rebuild'

module Rebuild
  class Runner
    def initialize(repo_path, primary_scripts)
      @repo_path = repo_path
      @primary_scripts = primary_scripts
    end

    def run
      puts "Run: #{@repo_path}"
    end
  end
end
