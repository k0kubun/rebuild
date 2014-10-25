require 'rebuild'

module Rebuild
  class CommandLineTools
    DATABASE          = '/Library/Application\ Support/com.apple.TCC/TCC.db'
    BUNDLE_IDENTIFIER = 'com.apple.Terminal'

    class << self
      def installed?
        system('xcode-select -p > /dev/null 2>&1')
      end

      def install
        obtain_accesibility

        `xcode-select --install`
        execute_scpt('start_install')

        sleep 5 until installed?
        execute_scpt('click_finish')
      end

      private

      # Enable Security & Privacy > Privacy > Accessibility for Terminal.app.
      def obtain_accesibility
        puts "Require accessibility for Terminal.app to click buttons"
        sql = <<-SQL
          INSERT OR REPLACE INTO access
          VALUES('kTCCServiceAccessibility','#{BUNDLE_IDENTIFIER}',0,1,1,NULL);
        SQL
        `sudo sqlite3 #{DATABASE} "#{sql}"`
      end

      def execute_scpt(name)
        script_dir  = File.expand_path('../../../script', __FILE__)
        script_path = File.join(script_dir, "#{name}.scpt")
        `sudo osascript #{script_path}`
      end
    end
  end
end
