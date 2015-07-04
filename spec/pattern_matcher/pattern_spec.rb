require 'spec_helper'

module PatternMatcher
  describe Pattern do
    describe '::build' do
      it 'returns an array of Pattern objects' do
        patterns = %w(foo,bar,baz a,b,c)

        collection = Pattern.build(patterns)

        expect(collection).to be_an_array_of Pattern
      end
    end

    describe '#pattern' do
      it 'parses a passed-in pattern string' do
        pattern = Pattern.new('foo,bar,baz')

        expect(pattern.pattern).to eq %w(foo bar baz)
      end
    end

    describe '#to_a' do
      it 'returns the parsed pattern, as an array' do
        pattern = Pattern.new('foo,bar,baz')

        expect(pattern.to_a).to eq %w(foo bar baz)
      end
    end
  end
end
