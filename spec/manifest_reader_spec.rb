require 'spec_helper'

describe ToyRobot::ManifestReader do

  describe '#read' do

    it 'reads from a default file' do
      subject = ToyRobot::ManifestReader.new
      expect(subject.file).to be_a File
    end

    it 'reads from custom file' do
      file_path = File.join(File.dirname(__FILE__), 'fixtures', 'manifest_example.txt')
      subject = ToyRobot::ManifestReader.new(file_path: file_path)
      expect(subject.file.path).to eq file_path
    end

    it 'returns an array with orders' do
      subject = ToyRobot::ManifestReader.new(file_path: File.join(File.dirname(__FILE__), 'fixtures', 'manifest_example.txt'))
      orders_array = [
        'MOVE',
        'PLACE 1,2,NORTH',
        'LEFT',
        'RIGHT',
        'REPORT'
      ]
      expect(subject.read).to match_array(orders_array)
    end

  end

end