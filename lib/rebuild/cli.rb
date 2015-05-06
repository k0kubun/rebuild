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
        opt.on('-k', '--keep-sudo')     { |v| options[:keep_sudo] = true }

        args = opt.parse!(ARGV)
        return show_usage    if options[:help]
        return print_version if options[:version]

        keep_sudo if options[:keep_sudo]

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

      # Vendored from:
      # https://github.com/mathiasbynens/dotfiles/blob/6e9822e879caed207f743c9eeadbf724610bff02/.osx#L5-L9
      def keep_sudo
        system(<<-EOS)
          sudo -v
          while true; do sudo -n true; sleep 1; kill -0 #{Process.pid} || exit; done 2>/dev/null &
        EOS
      end

      def bootstrap(repo, stdin, options)
        repo_path       = Repository.new(repo, options).fetch
        primary_scripts = (stdin || options[:dependency] || '').split

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
          script = install_sh(command)
          unless script.empty?
            Logger.info("Running #{install_sh_url(command)}...")
            exit system(script)
          end

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
            -k, [--keep-sudo]                      Keep sudo enabled while execution
            -d, [--directory=/path/to/clone]       Default: ~/PROJECT
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

      def install_sh(name)
        `curl -LSfs #{install_sh_url(name)} 2> /dev/null`
      end

      def install_sh_url(name)
        "https://raw.githubusercontent.com/#{name}/dotfiles/master/install.sh"
      end
    end
  end
end
