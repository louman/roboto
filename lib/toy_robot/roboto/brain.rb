module ToyRobot
  class Roboto
    class Brain

      extend Forwardable

      def_delegator :@speech, :speak

      attr_accessor :motor_cortex, :speech

      def initialize
        @motor_cortex = MotorCortex.new
        @speech       = Speech.new
      end

      def understand_order(order)
        order  = sanitized_order(order).split(' ')
        method = order.shift.downcase.to_sym
        if order.any?
          arguments = sanitized_args(order.shift)
        end
        { command: method, args: arguments }
      end

      private

      def sanitized_order(order)
        order.strip.squeeze(' ')
      end

      def sanitized_args(args)
        args = args.gsub(/ /, '').split(',')
        { x: args[0].to_i, y: args[1].to_i, f: args[2].downcase.to_sym }
      end

    end
  end
end