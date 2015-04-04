require 'spec_helper'

describe ToyRobot::Roboto::Speech do

  describe '#speak' do

    it 'prints a message' do
      expect { subject.speak('Hello sir!') }.to match_stdout('Hello sir!')
    end

  end

end