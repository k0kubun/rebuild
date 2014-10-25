require 'rebuild'
require 'unindent'

module Rebuild
  class CLI
    class << self
      def start
        return show_usage if ARGV.empty? && CommandLineTools.installed?

        unless CommandLineTools.installed?
          CommandLineTools.install
        end

        if ARGV.any?
          stdin = STDIN.gets unless STDIN.isatty
          bootstrap(ARGV, stdin)
        end
      end

      private

      def bootstrap(args, stdin)
        repo_path       = Repository.new(args.first).fetch
        primary_scripts = stdin

        runner = Runner.new(repo_path, primary_scripts)
        runner.run
      end

      def show_usage
        puts <<-EOS.unindent
          Commands:
            rebuild USER/PROJECT # execute all scripts in GitHub repo's root directory

        EOS
      end
    end
  end
end
