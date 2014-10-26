require 'rebuild'

module Rebuild
  class Homebrew
    class << self
      def installed?
        system('which brew')
      end

      def install
        Script.execute_exp('homebrew')
      end
    end
  end
end
