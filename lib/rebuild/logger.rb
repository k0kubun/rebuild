require 'rebuild'

module Rebuild
  class Logger
    COLOR_CODE = {
      red:   31,
      green: 32,
      cyan:  36,
    }

    class << self
      def info(text)
        puts green(text)
      end

      def finish(text)
        puts cyan(text)
      end

      def fatal(text)
        puts red("Error: #{text}")
        exit(1)
      end

      private

      def red(text)
        color_with(text, :red)
      end

      def green(text)
        color_with(text, :green)
      end

      def cyan(text)
        color_with(text, :cyan)
      end

      def color_with(text, color)
        "\e[#{COLOR_CODE[color]}m#{text}\e[0m"
      end
    end
  end
end
