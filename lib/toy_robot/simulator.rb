module ToyRobot
  class Simulator

    attr_reader :roboto, :table

    def initialize(table_size: {x: 5, y: 5})
      @roboto = Roboto.new
      @table  = Table.new(table_size)
      inform_roboto_about_table
    end

    def run(orders)
      orders.each do |order|
        understood = @roboto.understand_order(order)
        @roboto.execute_order(understood)
      end
    end

    private

    def inform_roboto_about_table
      @roboto.table_edges = @table.edges
    end

  end
end