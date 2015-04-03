module ToyRobot
  class ManifestReader

    attr_reader :file

    def initialize(file_path:nil)
      @file_path = file_path || File.join(File.dirname(__FILE__), 'files', 'manifest.txt')
      @file = File.open(@file_path)
    end

    def read
      @file.each_line.map(&:strip)
    end

  end
end