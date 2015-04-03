require 'spec_helper'

describe ToyRobot::Table do

  subject { ToyRobot::Table.new(x: 5, y: 3) }

  describe '#edges' do

    before do
      expect(subject).to receive(:x_limits).and_return({ min: 0, max: 5})
      expect(subject).to receive(:y_limits).and_return({ min: 1, max: 3})
    end

    it 'Returns the limits for X and Y axis' do
      expect(subject.edges).to eq({ x: { min: 0, max: 5 }, y: { min: 1, max: 3 } })
    end

  end

  describe '#x_limits' do

    it 'returns the limits for X axis' do
      expect(subject.x_limits).to eq({ min: 0, max: 4 })
    end

    it '0 is always the min' do
      expect(subject.x_limits[:min]).to eq(0)
    end

    it 'subtracts one from max' do
      expect(subject.x_limits[:max]).to eq(4)
    end

  end

  describe '#y_limits' do

    it 'returns the limits for Y axis' do
      expect(subject.y_limits).to eq({ min: 0, max: 2 })
    end

    it '0 is always the min' do
      expect(subject.y_limits[:min]).to eq(0)
    end

    it 'subtracts one from max' do
      expect(subject.y_limits[:max]).to eq(2)
    end

  end



end