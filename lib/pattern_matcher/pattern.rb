module PatternMatcher
  class Pattern
    attr_reader :pattern, :pattern_string

    ANYTHING_BUT_COMMAS = /[^,]+/

    def self.build(patterns)
      patterns.map { |pattern| Pattern.new(pattern) }
    end

    def initialize(pattern_string)
      @pattern_string = pattern_string
      @pattern = parse_pattern_string
    end

    def to_a
      pattern
    end

    private

    def parse_pattern_string
      pattern_string.scan(ANYTHING_BUT_COMMAS)
    end
  end
end
