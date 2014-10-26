require 'rebuild'
require 'set'

module Rebuild
  class Runner
    def initialize(repo_path, primary_scripts, scriptdir)
      @repo_path        = repo_path
      @primary_scripts  = primary_scripts
      @script_directory = scriptdir
    end

    def run
      return no_script_found if script_paths.empty?

      ordered_scripts.each do |script|
        absolute_path = File.join(absolute_script_directory, script)
        Logger.info("Running #{absolute_path}...")
        system('sh', absolute_path)
      end

      Logger.finish("Finished to rebuild #{absolute_script_directory}")
    end

    private

    def ordered_scripts
      inexistent_scripts = @primary_scripts - existent_scripts
      if inexistent_scripts.any?
        Logger.fatal("#{inexistent_scripts.join(', ')} can't be found in #{absolute_script_directory}")
      end

      @primary_scripts + (existent_scripts - @primary_scripts)
    end

    def existent_scripts
      target = File.join(absolute_script_directory, '*.sh')

      Dir.glob(target).map do |full_path|
        File.basename(full_path)
      end
    end

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
