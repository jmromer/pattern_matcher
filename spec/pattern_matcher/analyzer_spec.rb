require 'spec_helper'

module PatternMatcher
  describe Analyzer do
    include TestDataHelper
    subject(:analyzer) { Analyzer.new }

    describe '#best_fitting_pattern_for' do
      it 'returns the highest-scoring pattern for /w/x/y/z/' do
        matches = build_matcher_collection(path: '/w/x/y/z/')

        best_pattern = analyzer.best_fitting_pattern_for(matches: matches)

        expect(best_pattern).to eq '*,x,y,z'
      end

      it 'returns the highest-scoring pattern for a/b/c' do
        matches = build_matcher_collection(path: 'a/b/c')

        best_pattern = analyzer.best_fitting_pattern_for(matches: matches)

        expect(best_pattern).to eq 'a,*,*'
      end

      it 'returns the NO MATCH for foo/' do
        matches = build_matcher_collection(path: 'foo/')

        best_pattern = analyzer.best_fitting_pattern_for(matches: matches)

        expect(best_pattern).to eq 'NO MATCH'
      end

      it 'returns the NO MATCH for foo/bar/' do
        matches = build_matcher_collection(path: 'foo/bar/')

        best_pattern = analyzer.best_fitting_pattern_for(matches: matches)

        expect(best_pattern).to eq 'NO MATCH'
      end

      it 'returns the highest-scoring pattern for foo/bar/baz/' do
        matches = build_matcher_collection(path: 'foo/bar/baz/')

        best_pattern = analyzer.best_fitting_pattern_for(matches: matches)

        expect(best_pattern).to eq 'foo,bar,baz'
      end
    end

    # all_patterns from /spec/support/test_data_helper.rb
    def build_matcher_collection(path:)
      Matcher.build(patterns: Pattern.build(all_patterns), path: Path.new(path))
    end
  end
end
