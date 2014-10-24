require 'rebuild'

module Rebuild
  class Runner
    def initialize(repo_path, primary_scripts)
      @repo_path = repo_path
      @primary_scripts = primary_scripts
    end

    def run
      puts "run #{@repo_path}"
      p @primary_scripts
    end
  end
end
