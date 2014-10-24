require 'rebuild'
require 'unindent'

module Rebuild
  class CLI
    class << self
      def start
        bootstrap = Bootstrap.new
        if bootstrap.installed?
          show_usage if ARGV.empty?
        else
          bootstrap.install
        end
        return if ARGV.empty?

        repo_path       = Repository.new(ARGV.first).fetch
        primary_scripts = STDIN.gets unless STDIN.isatty

        runner = Runner.new(repo_path, primary_scripts)
        runner.run
      end

      private

      def show_usage
        puts <<-EOS.unindent
          Commands:
            rebuild USER/PROJECT # execute all scripts in GitHub repo's root directory

        EOS
      end
    end
  end
end
