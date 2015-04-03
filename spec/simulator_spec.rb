require 'spec_helper'

describe ToyRobot::Simulator do

  it 'has a table' do
    expect(subject.table).to be_an_instance_of(ToyRobot::Table)
  end

  it 'has a default 5x5 table' do
    expect(subject.table.x).to eq 5
    expect(subject.table.y).to eq 5
  end

  it 'allows custom table' do
    simulator = ToyRobot::Simulator.new(table_size: { x: 2, y: 3 } )
    expect(simulator.table.x).to eq 2
    expect(simulator.table.y).to eq 3
  end

  it 'has a roboto' do
    expect(subject.roboto).to be_an_instance_of(ToyRobot::Roboto)
  end

  it 'makes sure roboto is aware of table' do
    expect(subject.roboto.table_edges).to be_a(Hash)
  end

  describe '#run' do

    it 'execute orders' do
      subject.run(['MOVE', 'PLACE 1,2,SOUTH', 'MOVE', 'REPORT', 'LEFT', 'MOVE', 'RIGHT'])
      expect { subject.roboto.report }.to match_stdout('X: 2, Y: 1, F: south')
    end

  end

end