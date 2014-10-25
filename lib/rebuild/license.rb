require 'rebuild'

module Rebuild
  class License
    class << self
      def agreed?
        system('gcc 2>&1 | grep -v Agreeing > /dev/null')
      end

      def agree
        execute_exp('agree_license')
      end

      private

      def execute_exp(name)
        script_dir  = File.expand_path('../../../script', __FILE__)
        script_path = File.join(script_dir, "#{name}.exp")
        `sudo expect -f #{script_path}`
      end
    end
  end
end
