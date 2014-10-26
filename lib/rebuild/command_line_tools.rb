require 'rebuild'

module Rebuild
  class CommandLineTools
    DATABASE            = '/Library/Application\ Support/com.apple.TCC/TCC.db'
    SUPPORTED_TERMINALS = %w[
      com.apple.Terminal
      com.googlecode.iterm2
    ]

    class << self
      def installed?
        system('xcode-select -p > /dev/null 2>&1')
      end

      def install
        obtain_accesibility

        `xcode-select --install`
        Script.execute_scpt('start_install')
        sleep 5 until installed?
        Script.execute_scpt('click_done')
      end

      private

      # Enable Security & Privacy > Privacy > Accessibility for Terminal.app.
      def obtain_accesibility
        puts 'Require accessibility for terminal to click buttons'
        SUPPORTED_TERMINALS.each do |bundle_identifier|
          sql = <<-SQL
            INSERT OR REPLACE INTO access
            VALUES('kTCCServiceAccessibility','#{bundle_identifier}',0,1,0,NULL);
          SQL
          `sudo sqlite3 #{DATABASE} "#{sql}"`
        end
      end
    end
  end
end
