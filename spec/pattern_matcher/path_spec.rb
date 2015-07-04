require 'spec_helper'

module PatternMatcher
  describe Path do
    describe '::build' do
      it 'returns an array of Path objects' do
        paths = %w(/foo/bar/baz/ a/b/c)

        collection = Path.build(paths)

        expect(collection).to be_an_array_of Path
      end
    end

    describe '#path' do
      it 'parses a passed-in path string' do
        path = Path.new('foo/bar/baz')

        expect(path.path).to eq %w(foo bar baz)
      end

      it 'ignores leading and trailing slashes' do
        path = Path.new('/foo/bar/baz/')

        expect(path.path).to eq %w(foo bar baz)
      end
    end

    describe '#to_a' do
      it 'returns the parsed path, as an array' do
        path = Path.new('/foo/bar/baz/')

        expect(path.to_a).to eq %w(foo bar baz)
      end
    end
  end
end
