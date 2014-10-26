require 'rebuild'

module Rebuild
  class Homebrew
    class << self
      def installed?
        system('which brew > /dev/null')
      end

      def install
        Script.execute_sh('homebrew')
      end
    end
  end
end
