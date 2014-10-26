require 'rebuild'
require 'optparse'

module Rebuild
  class CLI
    DEFAULT_OPTIONS = {
      update:  false,
      version: false,
    }

    class << self
      def start
        options = DEFAULT_OPTIONS

        opt = OptionParser.new
        opt.on('-v', '--version')       { |v| options[:version] = true }
        opt.on('-f', '--force-update')  { |v| options[:update] = true }
        opt.on('-d', '--directory=VAL') { |v| options[:directory] = v }
        opt.on('-s', '--scriptdir=VAL') { |v| options[:scriptdir] = v }

        args = opt.parse!(ARGV)
        return print_version if options[:version]
        return show_usage if args.empty? && CommandLineTools.installed?

        CommandLineTools.install unless CommandLineTools.installed?
        License.agree            unless License.agreed?

        return if args.empty?
        command = args.first

        if command.include?('/')
          stdin = STDIN.read unless STDIN.isatty
          bootstrap(command, stdin, options)
        else
          run_command(command)
        end
      end

      private

      def bootstrap(repo, stdin, options)
        repo_path       = Repository.new(repo, options).fetch
        primary_scripts = (stdin || '').split

        runner = Runner.new(repo_path, primary_scripts, options[:scriptdir])
        runner.run
      end

      def run_command(command)
        case command
        when 'brew'
          command_brew
        else
          puts "Command #{command} is not found."
          puts
          show_usage
        end
      end

      def command_brew
        if Homebrew.installed?
          puts 'Homebrew is already installed.'
        else
          Homebrew.install
        end
      end

      def show_usage
        puts unindent(<<-EOS)                                                            # <- 80 columns
          Commands:
            rebuild                install command line tools, done
            rebuild USER/PROJECT   execute all scripts in GitHub repo's root directory
            rebuild brew           start homebrew installation and press ENTER for you

          Options:
            -v, [--version]                        Print version
            -f, [--force-update]                   By default, git pull is not executed
            -d, [--directory=/path/to/clone]       Default: /tmp/USER/PROJECT
            -s, [--scriptdir=/script/placed/dir]   Default: '' (root)

        EOS
      end

      def print_version
        puts "Rebuild version #{VERSION}"
      end

      def unindent(text)
        indent = text.split("\n").select {|line| !line.strip.empty? }.map {|line| line.index(/[^\s]/) }.compact.min || 0
        text.gsub(/^[[:blank:]]{#{indent}}/, '')
      end
    end
  end
end
