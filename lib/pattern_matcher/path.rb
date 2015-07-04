module PatternMatcher
  class Path
    attr_reader :path, :path_string

    ANYTHING_BUT_SLASHES = /[^\/]+/

    def self.build(paths)
      paths.map { |path| Path.new(path) }
    end

    def initialize(path_string)
      @path_string = path_string
      @path = parse_path_string
    end

    def to_a
      path
    end

    private

    def parse_path_string
      path_string.scan(ANYTHING_BUT_SLASHES)
    end
  end
end
