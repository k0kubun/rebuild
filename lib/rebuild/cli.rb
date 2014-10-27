require 'rebuild'
require 'optparse'
require 'unindent'

module Rebuild
  class CLI
    DEFAULT_OPTIONS = {
      help:    false,
      update:  false,
      version: false,
    }

    class << self
      def start
        @installed = CommandLineTools.installed?
        @gitconfig = GitConfig.instance
        options = DEFAULT_OPTIONS.merge(@gitconfig.rebuild_config)

        opt = OptionParser.new
        opt.on('-h', '--help')          { |v| options[:help] = true }
        opt.on('-v', '--version')       { |v| options[:version] = true }
        opt.on('-f', '--force-update')  { |v| options[:update] = true }
        opt.on('-d', '--directory=VAL') { |v| options[:directory] = v }
        opt.on('-s', '--scriptdir=VAL') { |v| options[:scriptdir] = v }

        args = opt.parse!(ARGV)
        return show_usage    if options[:help]
        return print_version if options[:version]

        CommandLineTools.install unless CommandLineTools.installed?
        License.agree            unless License.agreed?

        stdin = STDIN.read unless STDIN.isatty
        if args.empty?
          if options[:repo]
            bootstrap(options[:repo], stdin, options)
          elsif @installed
            show_usage
          end
        elsif args.first.include?('/')
          bootstrap(args.first, stdin, options)
        else
          run_command(args.first)
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
          # This is a secret feature because it is not so useful now
          command_brew
        when 'config'
          command_config
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

      def command_config
        if @gitconfig.has_rebuild_config?
          puts '.gitconfig is already initialized for rebuild.'
        else
          @gitconfig.add_rebuild_config
        end
      end

      def show_usage
        puts <<-EOS.unindent
          Commands:
            rebuild                install command line tools, done
            rebuild USER/PROJECT   execute all scripts in GitHub repo's root directory
            rebuild config         add rebuild config template to ~/.gitconfig

          Options:
            -h, [--help]                           Show this
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
