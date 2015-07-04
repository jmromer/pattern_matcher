module PatternMatcher
  class Analyzer
    def best_fitting_pattern_for(matches:)
      return 'NO MATCH' if no_positive_scores?(matches)

      highest_scoring_pattern = matches.sort.max_by(&:score)
      highest_scoring_pattern.pattern_string
    end

    private

    def no_positive_scores?(matches)
      matches.all? { |match| match.score <= 0 }
    end
  end
end
