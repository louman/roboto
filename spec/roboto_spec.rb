require 'spec_helper'

describe ToyRobot::Roboto do

  it 'has a brain' do
    expect(subject.brain).to be_an_instance_of(ToyRobot::Roboto::Brain)
  end

  it 'delegates speak to brain' do
    expect(subject.brain).to receive(:speak).with('something')
    subject.speak('something')
  end

  it 'delegates location to brain as motor_cortex' do
    expect(subject.brain).to receive(:motor_cortex)
    subject.location
  end

  it 'has a name' do
    subject.name = 'slave roboto'
    expect(subject.name).to eq 'slave roboto'
  end

  describe '#execute_order' do

    context 'without arguments' do

      it 'sends method' do
        expect(subject).to receive(:report)
        subject.execute_order(command: :report)
      end
      
    end

    context 'with arguments' do

      it 'sends method with arguments' do
        expect(subject).to receive(:place).with(x: 1, y: 2, f: :north)
        subject.execute_order(command: :place, args: { x: 1, y: 2, f: :north })
      end

    end

  end

  describe '#report' do

    context 'when roboto is not placed yet' do

      it 'advises' do
        expect(subject.brain).to receive(:speak).with('Roboto not placed yet, sir!')
        subject.report
      end

    end

    context 'when roboto is placed' do

      before do
        allow(subject).to receive(:location).and_return(double(to_s: 'X: 1, Y: 2, F: north'))
      end

      it 'reports its position based on location' do
        expect(subject.brain).to receive(:speak).with('X: 1, Y: 2, F: north')
        subject.report
      end

    end

  end

  describe '#place' do

    context 'when tries to place into an unsafe position' do

      before do
        expect(subject).to receive(:to_safe_location?).and_return(false)
      end

      it 'advises about danger' do
        expect(subject.brain).to receive(:speak).with('No can do, sir! If Roboto move Roboto fall.')
        subject.place(x: 1, y: 2, f: :north)
      end

    end

    context 'when tries to place into a safe position' do

      before do
        expect(subject).to receive(:to_safe_location?).and_return(true)
      end

      it 'successfully changes roboto location' do
        expect(subject.location).to receive(:reset)
        subject.place(x: 1, y: 2, f: :north)
      end

    end

  end

  describe '#move' do

    context 'when roboto is not placed yet' do

      it 'advises' do
        expect(subject.brain).to receive(:speak).with('Roboto not placed yet, sir!')
        subject.move
      end

    end

    context 'when roboto is placed' do

      context 'trying to move to a safe position' do

        before do
          expect(subject).to receive(:to_safe_location?).twice.and_return(true)
          subject.place(x: 1, y: 1, f: :north)
        end

        it 'moves one unit forward' do
          subject.move
          expect(subject.location.x).to eq 1
          expect(subject.location.y).to eq 2
        end

      end

      context 'trying to move to an unsafe position' do

        before do
          expect(subject).to receive(:to_safe_location?).and_return(true)
          subject.place(x: 1, y: 1, f: :north)
        end

        it 'advises about danger' do
          expect(subject).to receive(:to_safe_location?).and_return(false)
          expect(subject.brain).to receive(:speak).with('No can do, sir! If Roboto move Roboto fall.')
          subject.place(x: 1, y: 2, f: :north)
        end

      end

    end

  end

  describe '#left' do

    context 'when roboto is not placed yet' do

      it 'advises' do
        expect(subject.brain).to receive(:speak).with('Roboto not placed yet, sir!')
        subject.left
      end

    end

    context 'when roboto is placed' do

      before do
        expect(subject).to receive(:to_safe_location?).and_return(true)
        subject.place(x: 1, y: 1, f: :north)
      end

      it 'rotates 90 degrees to the left' do
        subject.left
        expect(subject.location.f).to eq :west
      end

    end

  end

  describe '#right' do

    context 'when roboto is not placed yet' do

      it 'advises' do
        expect(subject.brain).to receive(:speak).with('Roboto not placed yet, sir!')
        subject.right
      end

    end

    context 'when roboto is placed' do

      before do
        expect(subject).to receive(:to_safe_location?).and_return(true)
        subject.place(x: 1, y: 1, f: :north)
      end

      it 'rotates 90 degrees to the right' do
        subject.right
        expect(subject.location.f).to eq :east
      end

    end

  end

  describe '#placed?' do

    it 'returns true if roboto is placed' do
      expect(subject.location).to receive(:nil?).and_return(false)
      expect(subject.placed?).to be_truthy
    end

    it 'returns false if roboto is not placed' do
      expect(subject.placed?).to be_falsy
    end

  end

end