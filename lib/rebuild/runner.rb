require 'rebuild'

module Rebuild
  class Runner
    def initialize(repo_path, primary_scripts, scriptdir)
      @repo_path        = repo_path
      @primary_scripts  = primary_scripts
      @script_directory = scriptdir
    end

    def run
      return no_script_found if script_paths.empty?

      script_paths.each do |path|
        Logger.info("Running #{path}...")
        system('sh', path)
      end

      Logger.finish("Finished to rebuild #{absolute_script_directory}")
    end

    private

    def script_paths
      target = File.join(absolute_script_directory, '*.sh')
      Dir.glob(target)
    end

    def no_script_found
      puts "No *.sh found in #{absolute_script_directory}"
    end

    def absolute_script_directory
      File.join([@repo_path, @script_directory].compact)
    end
  end
end
