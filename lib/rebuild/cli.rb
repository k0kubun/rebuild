require 'rebuild'

module Rebuild
  class CLI
    class << self
      def start
        return show_usage if ARGV.empty? && CommandLineTools.installed?

        CommandLineTools.install unless CommandLineTools.installed?
        License.agree            unless License.agreed?

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
        puts unindent(<<-EOS)
          Commands:
            rebuild USER/PROJECT # execute all scripts in GitHub repo's root directory

        EOS
      end

      def unindent(text)
        indent = text.split("\n").select {|line| !line.strip.empty? }.map {|line| line.index(/[^\s]/) }.compact.min || 0
        text.gsub(/^[[:blank:]]{#{indent}}/, '')
      end
    end
  end
end
