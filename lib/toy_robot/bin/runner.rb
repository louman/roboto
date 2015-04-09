module ToyRobot
  module Bin
    class Runner

      include IOUtils

      attr_reader :simulator, :roboto, :selected_option

      def initialize
        @simulator   = ToyRobot::Simulator.new
        @roboto      = @simulator.roboto
        @roboto.name = robots.sample
      end

      def start
        show_art
        show_help
        show_options
        @selected_option = capture_input
        handle_selected_option
      end

      private

      def capture_input
        gets.chomp.strip
      end

      def handle_selected_option
        case selected_option
        when '1'
          input_by_hand
        when '2'
          input_from_file
        else
          _print 'Invalid option, terminating simulator.'
        end
      end

      def input_by_hand
        boot_roboto('Ok, preparing roboto for manual orders')
        _print green("-- #{@roboto.name} reporting for duty. What is you first order sir?")
        command = capture_input
        while command
          begin
            @simulator.run([command])
          rescue StandardError
            _print red('Order not recognized, sir!')
          end  
          _print green("#{@roboto.name} waiting for new orders, sir!")
          command = capture_input
        end
      end

      def input_from_file
        boot_roboto('Ok, preparing roboto for orders manifest')
        @simulator.run(read_manifest)
      end

      def read_manifest
        ToyRobot::ManifestReader.new.read
      end

      def show_art
        _print art
      end

      def show_help
        _print help
      end

      def show_options
        _print '1) Input orders by hand'
        _print '2) Input orders from file'
      end

      def boot_roboto(acknowledge_message)
        print_with_delay yellow(acknowledge_message)
        print_with_delay yellow("Booting #{@roboto.name}")
        print_with_delay yellow('Calibrating controls')
        print_with_delay yellow('Activating AI')
        print_with_delay yellow('1, 2, 3 testing')
      end

      def help
        rows = []
        rows << ['Type "exit" anytime to exit simulator']
        rows << ['Valid commands are: PLACE, MOVE, LEFT, RIGHT, REPORT']
        rows << ['PLACE: puts the toy robot on the table in position X,Y and facing NORTH, SOUTH, EAST or WEST.']
        rows << ['MOVE: moves the toy robot one unit forward in the direction it is currently facing.']
        rows << ['LEFT: rotates the robot 90 degrees counter-clockwise without changing the position of the robot.']
        rows << ['RIGHT: rotates the robot 90 degrees clockwise without changing the position of the robot.']
        rows << ['REPORT: announces the X,Y and F of the robot.']
        table = Terminal::Table.new :rows => rows, title: 'Welcome to the Toy Robot Simulator!'
      end

      def robots
        ['T-800', 'Optimus Prime', 'R2-D2', 'C-3PO', 'Data', 'Sonny', 'Wall-E', 'Rosey', 'Robocop', 'T-1000']
      end

      def art
        art = AsciiArt.new(File.join(File.dirname(__FILE__), '..', 'files', 'roboto.jpg'))
        art.to_ascii_art(width: 70)
      end

    end
  end
end