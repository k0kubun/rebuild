require 'rebuild'

module Rebuild
  class License
    class << self
      def agreed?
        system('gcc 2>&1 | grep -v Agreeing > /dev/null')
      end

      def agree
        Script.execute_exp('agree_license', sudo: true)
      end
    end
  end
end
