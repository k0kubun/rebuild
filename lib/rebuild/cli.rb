require 'rebuild'
require 'optparse'

module Rebuild
  class CLI
    class << self
      def start
        options = {}

        opt = OptionParser.new
        opt.on('-d', '--directory=VAL') { |v| options[:directory] = v }
        opt.on('-s', '--scriptdir=VAL') { |v| options[:scriptdir] = v }

        args = opt.parse!(ARGV)
        return show_usage if args.empty? && CommandLineTools.installed?

        CommandLineTools.install unless CommandLineTools.installed?
        License.agree            unless License.agreed?

        if args.any?
          stdin = STDIN.gets unless STDIN.isatty
          bootstrap(args, stdin, options)
        end
      end

      private

      def bootstrap(args, stdin, options)
        repo_path       = Repository.new(args.first, options[:directory]).fetch
        primary_scripts = stdin

        runner = Runner.new(repo_path, primary_scripts, options[:scriptdir])
        runner.run
      end

      def show_usage
        puts unindent(<<-EOS)
          Commands:
            rebuild                              # install command line tools, done
            rebuild USER/PROJECT                 # execute all scripts in GitHub repo's root directory

          Options:
            -f, [--force-update]                 # By default, git pull is not executed
            -d, [--directory=/path/to/clone]     # Default: /tmp/USER/PROJECT
            -s, [--scriptdir=/script/placed/dir] # Default: '' (root)

        EOS
      end

      def unindent(text)
        indent = text.split("\n").select {|line| !line.strip.empty? }.map {|line| line.index(/[^\s]/) }.compact.min || 0
        text.gsub(/^[[:blank:]]{#{indent}}/, '')
      end
    end
  end
end
