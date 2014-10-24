require 'rebuild'
require 'unindent'

module Rebuild
  class CLI
    class << self
      def start
        return show_usage if ARGV.length != 1

        repo_path       = Repository.new(ARGV.first).fetch
        primary_scripts = STDIN.gets unless STDIN.isatty

        runner = Runner.new(repo_path, primary_scripts)
        runner.run
      end

      private

      def show_usage
        puts <<-EOS.unindent
          Commands:
            rebuild              # install command line tools
            rebuild USER/PROJECT # execute all scripts in GitHub repo's rebuild directory

        EOS
      end
    end
  end
end
