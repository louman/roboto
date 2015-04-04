require 'spec_helper'

describe ToyRobot::Roboto::Brain do

  it 'has a motor cortex' do
    expect(subject.motor_cortex).to be_an_instance_of(ToyRobot::Roboto::MotorCortex)
  end

  it 'has speech' do
    expect(subject.speech).to be_an_instance_of(ToyRobot::Roboto::Speech)
  end

  it 'delegates speak to Speech' do
    expect(subject.speech).to receive(:speak).with('something')
    subject.speak('something')
  end

  describe '#understand_order' do

    it 'understand order with bad input' do
      expect(subject.understand_order(' PLACE   1,2,nORTH')).to eq({ command: :place, args: { x: 1, y: 2, f: :north} })
    end

    context 'when ordering placement' do

      it 'sanitizes args' do
        expect(subject.understand_order('PLACE 1,2,NORTH')[:args]).to eq({ x: 1, y: 2, f: :north})
      end

    end

    

  end

end