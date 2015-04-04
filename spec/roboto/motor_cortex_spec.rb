require 'spec_helper'

describe ToyRobot::Roboto::MotorCortex do

  it 'has a list of cardinal directions' do
    expect(ToyRobot::Roboto::MotorCortex).to have_constant(:CARDINAL_DIRECTIONS)
  end

  it 'has a list of move directions' do
    expect(ToyRobot::Roboto::MotorCortex).to have_constant(:MOVE)
  end

  describe '#reset' do

    subject { ToyRobot::Roboto::MotorCortex.new(x: 2, y: 3, f: :north) }

    it 'sets X, Y and forwarding direction' do
      subject.reset(x: 1, y: 2, f: :south)
      expect(subject.x).to eq 1
      expect(subject.y).to eq 2
      expect(subject.f).to eq :south
    end

    it 'raises an exception if cardinal direction is not recognized' do
      expect { subject.reset(x: 1, y: 2, f: :southwest) }.to raise_error('southwest is not a recognized direction')
    end

  end

  describe '#rotate_ccw' do

    context 'when facing north' do

      subject { ToyRobot::Roboto::MotorCortex.new(f: :north) }

      it 'rotates to west' do
        subject.rotate_ccw
        expect(subject.f).to eq :west
      end

    end

    context 'when facing east' do

      subject { ToyRobot::Roboto::MotorCortex.new(f: :east) }

      it 'rotates to north' do
        subject.rotate_ccw
        expect(subject.f).to eq :north
      end

    end

    context 'when facing south' do

      subject { ToyRobot::Roboto::MotorCortex.new(f: :south) }

      it 'rotates to east' do
        subject.rotate_ccw
        expect(subject.f).to eq :east
      end

    end

    context 'when facing west' do

      subject { ToyRobot::Roboto::MotorCortex.new(f: :west) }

      it 'rotates to south' do
        subject.rotate_ccw
        expect(subject.f).to eq :south
      end

    end

  end

  describe '#rotate_cw' do

    context 'when facing north' do

      subject { ToyRobot::Roboto::MotorCortex.new(f: :north) }

      it 'rotates to east' do
        subject.rotate_cw
        expect(subject.f).to eq :east
      end

    end

    context 'when facing east' do

      subject { ToyRobot::Roboto::MotorCortex.new(f: :east) }

      it 'rotates to south' do
        subject.rotate_cw
        expect(subject.f).to eq :south
      end

    end

    context 'when facing south' do

      subject { ToyRobot::Roboto::MotorCortex.new(f: :south) }

      it 'rotates to west' do
        subject.rotate_cw
        expect(subject.f).to eq :west
      end

    end

    context 'when facing west' do

      subject { ToyRobot::Roboto::MotorCortex.new(f: :west) }

      it 'rotates to north' do
        subject.rotate_cw
        expect(subject.f).to eq :north
      end

    end

  end

  describe '#forward' do

    context 'when facing north' do

      subject { ToyRobot::Roboto::MotorCortex.new(x: 1, y: 1, f: :north) }

      it 'increases Y axis by one' do
        subject.forward
        expect(subject.y).to eq 2
      end

      it 'keeps X axis the same' do
        subject.forward
        expect(subject.x).to eq 1
      end

      it 'keeps forwarding direction the same' do
        subject.forward
        expect(subject.f).to eq :north
      end

    end

    context 'when facing east' do

      subject { ToyRobot::Roboto::MotorCortex.new(x: 1, y: 1, f: :east) }

      it 'increases X axis by one' do
        subject.forward
        expect(subject.x).to eq 2
      end

      it 'keeps Y axis the same' do
        subject.forward
        expect(subject.y).to eq 1
      end

      it 'keeps forwarding direction the same' do
        subject.forward
        expect(subject.f).to eq :east
      end

    end

    context 'when facing south' do

      subject { ToyRobot::Roboto::MotorCortex.new(x: 1, y: 1, f: :south) }

      it 'decreases Y axis by one' do
        subject.forward
        expect(subject.y).to eq 0
      end

      it 'keeps X axis the same' do
        subject.forward
        expect(subject.x).to eq 1
      end

      it 'keeps forwarding direction the same' do
        subject.forward
        expect(subject.f).to eq :south
      end

    end

    context 'when facing west' do

      subject { ToyRobot::Roboto::MotorCortex.new(x: 1, y: 1, f: :west) }

      it 'decreases X axis by one' do
        subject.forward
        expect(subject.x).to eq 0
      end

      it 'keeps Y axis the same' do
        subject.forward
        expect(subject.y).to eq 1
      end

      it 'keeps forwarding direction the same' do
        subject.forward
        expect(subject.f).to eq :west
      end

    end

  end

  describe '#forward_prediction' do

    context 'when facing north' do

      subject { ToyRobot::Roboto::MotorCortex.new(x: 1, y: 1, f: :north) }

      it 'increases Y axis by one' do
        expect(subject.forward_prediction).to eq [1, 2]
      end

    end

    context 'when facing east' do

      subject { ToyRobot::Roboto::MotorCortex.new(x: 1, y: 1, f: :east) }

      it 'increases X axis by one' do
        expect(subject.forward_prediction).to eq [2, 1]
      end

    end

    context 'when facing south' do

      subject { ToyRobot::Roboto::MotorCortex.new(x: 1, y: 1, f: :south) }

      it 'decreases Y axis by one' do
        expect(subject.forward_prediction).to eq [1, 0]
      end

    end

    context 'when facing west' do

      subject { ToyRobot::Roboto::MotorCortex.new(x: 1, y: 1, f: :west) }

      it 'decreases X axis by one' do
        expect(subject.forward_prediction).to eq [0, 1]
      end

    end

  end

  describe '#to_s' do

    subject { ToyRobot::Roboto::MotorCortex.new(x: 3, y: 6, f: :north) }

    it 'returns a formated string with axis and forwarding direction' do
      expect(subject.to_s).to eq 'X: 3, Y: 6, F: north'
    end

    context 'when X is nil' do

      subject { ToyRobot::Roboto::MotorCortex.new(x: nil, y: 6, f: :north) }

      it 'says N/A' do
        expect(subject.to_s).to eq 'X: N/A, Y: 6, F: north'
      end

    end

    context 'when Y is nil' do

      subject { ToyRobot::Roboto::MotorCortex.new(x: 2, y: nil, f: :north) }

      it 'says N/A' do
        expect(subject.to_s).to eq 'X: 2, Y: N/A, F: north'
      end

    end

    context 'when F is nil' do

      subject { ToyRobot::Roboto::MotorCortex.new(x: 2, y: 3, f: nil) }

      it 'says N/A' do
        expect(subject.to_s).to eq 'X: 2, Y: 3, F: N/A'
      end

    end

  end

  describe '#nil?' do

    context 'when X, Y and F are present' do

      subject { ToyRobot::Roboto::MotorCortex.new(x: 3, y: 6, f: :north) }

      it 'returns false' do
        expect(subject.nil?).to be_falsy
      end

    end

    context 'when X or Y or F are nil' do

      subject { ToyRobot::Roboto::MotorCortex.new(x: 3, y: nil, f: :north) }

      it 'returns true' do
        expect(subject.nil?).to be_truthy
      end

    end

  end

end