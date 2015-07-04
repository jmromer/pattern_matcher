require 'spec_helper'

module PatternMatcher
  describe Matcher do
    it 'is sortable by pattern string, in descending order by default' do
      patterns = Pattern.build(%w(a,b,c foo,bar,baz))
      path     = Path.new('/foo/bar/baz')
      collection = Matcher.build(patterns: patterns, path: path)

      sorted = collection.sort.map(&:pattern_string)

      expect(sorted).to eq %w(foo,bar,baz a,b,c)
    end

    describe '::build' do
      it 'builds a collection of Matcher objects' do
        patterns = Pattern.build(%w(foo,bar,baz a,b,c))
        path     = Path.new('/foo/bar/baz')

        collection = Matcher.build(patterns: patterns, path: path)

        expect(collection).to be_an_array_of Matcher
      end
    end

    describe '#evaluate' do
      it 'compares a path to a given pattern, yielding a score' do
        matcher = build_matcher(path: '/foo/bar/baz/', pattern: 'foo,bar,baz')

        matcher.evaluate

        expect(matcher.score).to eq 100
      end

      context 'given a 3-segment pattern' do
        it 'proportionately penalizes score for an unmatched segment' do
          matcher = build_matcher(path: '/foo/bar/baz/', pattern: 'foo,bar,boo')

          matcher.evaluate

          expect(matcher.score).to eq(100 - 33)
        end

        it 'penalizes half-credit for a wildcard match' do
          matcher = build_matcher(path: '/foo/bar/baz/', pattern: 'foo,bar,*')

          matcher.evaluate

          expect(matcher.score).to eq(100 - 33 / 2)
        end

        it 'zeroes score for mismatch in number of segments' do
          matcher = build_matcher(path: '/foo/bar/', pattern: 'foo,bar,baz')

          matcher.evaluate

          expect(matcher.score).to eq 0
        end
      end

      context 'given a 4-segment pattern' do
        it 'proportionately penalizes score for an unmatched segment' do
          matcher = build_matcher(path: 'w/x/y/z/', pattern: 'w,x,y,a')

          matcher.evaluate

          expect(matcher.score).to eq(100 - 25)
        end

        it 'penalizes half-credit for a wildcard match' do
          matcher = build_matcher(path: 'w/x/y/z/', pattern: 'w,x,y,*')

          matcher.evaluate

          expect(matcher.score).to eq(100 - 25 / 2)
        end
      end
    end

    describe '#pattern_string' do
      it 'returns the pattern as a string' do
        matcher = build_matcher(path: '/foo/bar/baz/', pattern: 'foo,bar,baz')

        pattern = matcher.pattern_string

        expect(pattern).to eq 'foo,bar,baz'
      end
    end

    def build_matcher(path:, pattern:)
      Matcher.new(pattern: Pattern.new(pattern), path: Path.new(path))
    end
  end
end
