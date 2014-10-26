require 'rebuild'

module Rebuild
  class Script
    class << self
      def execute_scpt(name)
        script_path = File.join(script_dir, "#{name}.scpt")
        `sudo osascript #{script_path}`
      end

      def execute_exp(name)
        script_path = File.join(script_dir, "#{name}.exp")
        `sudo expect -f #{script_path}`
      end

      private

      def script_dir
        File.expand_path('../../../script', __FILE__)
      end
    end
  end
end
