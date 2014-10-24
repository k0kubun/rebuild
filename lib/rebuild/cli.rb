require 'rebuild'
require 'unindent'

module Rebuild
  class CLI
    class << self
      def run
        return show_usage if ARGV.empty?
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
