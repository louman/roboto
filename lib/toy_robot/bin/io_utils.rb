module ToyRobot
  module Bin
    module IOUtils

      # puts a message and sleep
      def print_with_delay(msg, delay_time=2)
        _print msg
        delay delay_time
      end

      # just a wrapper for puts
      def _print(msg)
        puts msg
      end

      # just a wrapper for sleep
      def delay(delay_time)
        sleep delay_time
      end

      # returns a yellowish string
      def yellow(text)
        Rainbow(text).yellow
      end

      # returns a greenish string
      def green(text)
        Rainbow(text).green
      end

      # returns a reddish string
      def red(text)
        Rainbow(text).red
      end

    end
  end
end