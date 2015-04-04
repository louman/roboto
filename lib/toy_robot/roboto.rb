module ToyRobot
  class Roboto

    extend Forwardable

    def_delegator :@brain, :speak
    def_delegator :@brain, :motor_cortex, :location
    def_delegator :@brain, :understand_order

    attr_accessor :table_edges, :brain, :name

    def initialize
      @brain = Brain.new
      @name  = 'Roboto'
    end

    # Sends order's method
    def execute_order(order)
      if order[:args].nil?
        send(order[:command])
      else
        send(order[:command], order[:args])
      end
    end

    # Changes roboto location if is safe
    # otherwise says advise message
    def place(x:, y:, f:)
      safe(x, y) do
        location.reset(x: x.to_i, y: y.to_i, f: f.downcase.to_sym)
      end
    end

    # Moves roboto one unit forward to facing direction if roboto is placed
    # and it's safe
    # otherwise says advise message
    def move
      if_placed do
        x, y = location.forward_prediction
        safe(x, y) do
          location.forward
        end
      end
    end

    # Says current location if roboto is placed
    # otherwise says advise message
    def report
      if_placed do
        puts speak(location.to_s)
      end
    end

    # Rotates roboto 90 degrees to the left if roboto is placed
    # otherwise says advise message
    def left
      if_placed do
        location.rotate_ccw
      end
    end

    # Rotates roboto 90 degrees to the right if roboto is placed
    # otherwise says advise message
    def right
      if_placed do
        location.rotate_cw
      end
    end

    # Returns true if location is nil
    def placed?
      !location.nil?
    end

    private

    def safe(x, y)
      to_safe_location?(x, y) ? yield : speak("No can do, sir! If #{name} move #{name} fall.")
    end

    def to_safe_location?(new_x, new_y)
      new_x.between?(table_edges[:x][:min], table_edges[:x][:max]) && new_y.between?(table_edges[:y][:min], table_edges[:y][:max])
    end

    def if_placed
      placed? ? yield : speak("#{name} not placed yet, sir!")
    end

  end
end