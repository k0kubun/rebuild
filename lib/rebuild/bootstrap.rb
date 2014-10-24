require 'rebuild'
require 'open3'

module Rebuild
  class Bootstrap
    def installed?
      system('xcode-select -p > /dev/null')
    end

    def install
      return if installed?

      `xcode-select --install`
      execute_scpt('click_install')
      execute_scpt('click_agree')

      sleep 5 until installed?
      execute_scpt('click_finish')
    end

    private

    def execute_scpt(name)
      script_dir  = File.expand_path('../../../script', __FILE__)
      script_path = File.join(script_dir, "#{name}.scpt")
      `osascript #{script_path}`
    end
  end
end
