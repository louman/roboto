require 'spec_helper'

describe ToyRobot::Bin::IOUtils do

  let(:dummy_class) { Class.new { extend ToyRobot::Bin::IOUtils } }

  before do
    allow_any_instance_of(Object).to receive(:sleep)
  end

  describe '#print_with_delay' do

    it 'prints a message' do
      expect { dummy_class.print_with_delay('a message') }.to match_stdout('a message')
    end

    it 'has a default delay of 2 seconds' do
      expect(dummy_class).to receive(:delay).with(2)
      dummy_class.print_with_delay('a message')
    end

    it 'can have custom delay time' do
      expect(dummy_class).to receive(:delay).with(5)
      dummy_class.print_with_delay('a message', 5)
    end

  end

  describe '#_print' do

    it 'prints a message' do
      expect { dummy_class._print('a message') }.to match_stdout('a message')
    end

  end

  describe '#delay' do

    it 'sleeps for desired time' do
      expect(dummy_class).to receive(:sleep).with(3)
      dummy_class.delay 3
    end

  end

  describe '#yellow' do

    it 'returns a yellowish string' do
      expect(dummy_class.yellow('yellowish string')).to eq "\e[33myellowish string\e[0m"
    end

  end

  describe '#green' do

    it 'returns a greenish string' do
      expect(dummy_class.green('greenish string')).to eq "\e[32mgreenish string\e[0m"
    end

  end

  describe '#reddish' do

    it 'returns a reddish string' do
      expect(dummy_class.red('reddish string')).to eq "\e[31mreddish string\e[0m"
    end

  end

end