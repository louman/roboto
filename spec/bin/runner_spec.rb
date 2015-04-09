require 'spec_helper'

describe ToyRobot::Bin::Runner do

  before do
    allow_any_instance_of(Object).to receive(:puts)
    allow(subject).to receive(:capture_input) { '1' }
  end

  it 'has a simulator' do
    expect(subject.simulator).to be_an_instance_of(ToyRobot::Simulator)
  end

  it 'has a roboto' do
    expect(subject.roboto).to be_an_instance_of(ToyRobot::Roboto)
  end

  it 'assigns roboto a random name' do
    allow_any_instance_of(ToyRobot::Bin::Runner).to receive(:robots).and_return(['random name'])
    subject = ToyRobot::Bin::Runner.new
    expect(subject.roboto.name).to eq 'random name'
  end

  describe '#start' do

    context 'checking prints' do

      before do
        allow(subject).to receive(:handle_selected_option)
      end

      it 'shows art' do
        expect(subject).to receive(:show_art)
        subject.start
      end

      it 'shows help' do
        expect(subject).to receive(:show_help)
        subject.start
      end

      it 'shows options' do
        expect(subject).to receive(:show_options)
        subject.start
      end

    end

    it 'captures user option' do
      allow(subject).to receive(:handle_selected_option)
      subject.start
      expect(subject.selected_option).to eq '1'
    end

    context 'handling selected option' do

      context 'when 1' do

        it 'inputs by hand' do
          expect(subject).to receive(:input_by_hand)
          subject.start
        end
        
      end

      context 'when 2' do

        before do
          allow(subject).to receive(:capture_input) { '2' }
        end

        it 'inputs from file' do
          expect(subject).to receive(:input_from_file)
          subject.start
        end

      end

      context 'when else' do

        before do
          allow(subject).to receive(:capture_input) { '3' }
          allow(subject).to receive(:show_art)
          allow(subject).to receive(:show_help)
          allow(subject).to receive(:show_options)
        end

        it 'prints termination message' do
          expect(subject).to receive(:_print).with('Invalid option, terminating simulator.')
          subject.start
        end
      end

    end

  end

end