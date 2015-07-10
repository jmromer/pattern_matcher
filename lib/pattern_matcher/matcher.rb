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
      other_matcher.pattern_string <=> pattern_string
    end

    def evaluate
      pattern.zip(path).reduce(100) do |score, (pattern_seg, path_seg)|
        segment_score(score, pattern_seg, path_seg)
      end
    end

    def segment_score(score, pattern_seg, path_seg)
      if pattern_seg == '*'
        score -= half_segment_worth
      elsif pattern_seg == path_seg
        score
      elsif path_seg.nil?
        0
      else
        score -= one_segment_worth
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
