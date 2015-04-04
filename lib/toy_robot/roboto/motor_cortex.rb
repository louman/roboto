module ToyRobot
  class Roboto
    class MotorCortex

      attr_accessor :x, :y, :f

      CARDINAL_DIRECTIONS = [:north, :east, :south, :west]
      MOVE = { north: { x: 0,  y: 1  },
               east:  { x: 1,  y: 0  },
               south: { x: 0,  y: -1 },
               west:  { x: -1, y: 0  } }

      def initialize(x: nil, y: nil, f: nil)
        reset(x: x, y: y, f: f)
      end

      # Sets X, Y and forwarding direction
      def reset(x:, y:, f:)
        raise "#{f} is not a recognized direction" unless f.nil? || CARDINAL_DIRECTIONS.include?(f)
        @x = x
        @y = y
        @f = f
      end

      # Rotates -90 degrees
      def rotate_ccw
        @f = rotation(-1)
      end

      # Rotates 90 degrees
      def rotate_cw
        @f = rotation(1) || CARDINAL_DIRECTIONS[0]
      end

      # Increaseas one unit to forwarding direction
      def forward
        new_x, new_y = forward_prediction
        reset(x: new_x, y: new_y, f: @f)
      end

      # Calculates new position to move forward
      def forward_prediction
        return @x + MOVE[@f][:x], @y + MOVE[@f][:y]
      end

      # Returns a formated string with axis and forwarding direction
      def to_s
        "X: #{value_or_not_available(@x)}, Y: #{value_or_not_available(@y)}, F: #{value_or_not_available(@f)}"
      end

      # Returns true X or Y or F is nil
      def nil?
        @x.nil? || @y.nil? || @f.nil?
      end

      private

      def value_or_not_available(value)
        value.nil? ? 'N/A' : value
      end

      def rotation(step)
        CARDINAL_DIRECTIONS[CARDINAL_DIRECTIONS.index(@f) + step]
      end
    end
  end
end