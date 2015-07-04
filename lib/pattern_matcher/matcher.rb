module PatternMatcher
  class Matcher
    include Enumerable
    def self.build(patterns:, path:)
      patterns.map { |pattern| Matcher.new(pattern: pattern, path: path) }
    end

    def initialize(pattern:, path:)
      @pattern = pattern
      @path = path
    end

    def pattern
      @pattern.to_a
    end

    def path
      @path.to_a
    end

    def score
      @score ||= evaluate
    end

    def pattern_string
      @pattern.pattern_string
    end

    def <=>(other_matcher)
      score <=> other_matcher
    end

    def evaluate
      pattern.zip(path).reduce(100) do |score, (pattern_seg, path_seg)|
        case pattern_seg
        when '*'      then score -= half_segment_worth
        when path_seg then score
        else score -= one_segment_worth
        end
      end
    end

    private

    def one_segment_worth
      100 / path.length
    end

    def half_segment_worth
      one_segment_worth / 2
    end
  end
end
