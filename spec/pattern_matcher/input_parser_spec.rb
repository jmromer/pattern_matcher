require 'spec_helper'

module PatternMatcher
  describe InputParser do
    subject(:parser) { InputParser.new }

    describe '#parse' do
      context 'given valid input' do
        let(:valid_input) { "2\na,b,c\nd,e,f\n2\na/b/c\nd/e/f\n" }

        it 'correctly parses the number of patterns and paths' do
          parser.parse(valid_input)

          numbers = parser.lengths

          expect(numbers).to eq(patterns: 2, paths: 2)
        end

        it 'correctly parses patterns' do
          parser.parse(valid_input)

          patterns = parser.patterns

          expect(patterns).to eq %w(a,b,c d,e,f)
        end

        it 'correctly parses paths' do
          parser.parse(valid_input)

          paths = parser.paths

          expect(paths).to eq %w(a/b/c d/e/f)
        end
      end

      context 'given invalid input' do
        it 'raises an error unless given exactly two digit-lines' do
          bad_input = "1\na,b,c\n1\na/b/c\n1\na,b,c"

          expect { parser.parse(bad_input) }.to raise_error(ArgumentError)
        end

        it 'raises an error unless the given numbers are valid' do
          bad_input = "2\na,b,c\n2\na/b/c"

          expect { parser.parse(bad_input) }.to raise_error(ArgumentError)
        end
      end
    end
  end
end
