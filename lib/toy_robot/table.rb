module ToyRobot
  class Table

    attr_reader :roboto, :x, :y

    def initialize(x:, y:)
      @x = x
      @y = y
    end

    # Returns a Hash with the limits for X and Y axis
    def edges
      { x: x_limits, y: y_limits }
    end

    # Returns a hash with min and max values for X based on initial value
    def x_limits
      { min: 0, max: @x-1 }
    end

    # Returns a hash with min and max values for Y based on initial value
    def y_limits
      { min: 0, max: @y-1 }
    end

  end
end