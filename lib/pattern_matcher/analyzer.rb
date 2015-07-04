module PatternMatcher
  class Analyzer
    def best_fitting_pattern_for(matches:)
      matches.max_by(&:score).pattern_string
    end
  end
end
