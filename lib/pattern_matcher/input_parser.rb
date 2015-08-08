module PatternMatcher
  class InputParser
    attr_reader :lengths, :patterns, :paths

    def parse(str)
      @raw_lengths, @raw_inputs = split_into_lengths_and_strings(str)
      @raw_lengths.map!(&:to_i)

      fail ArgumentError, 'Invalid Input' unless valid?

      @lengths = map_input_type_to_qty_provided
      @patterns = @raw_inputs.first(lengths[:patterns])
      @paths = @raw_inputs.last(lengths[:paths])

      self
    end

    private

    attr_reader :raw_lengths

    def valid?
      total_number_of_patterns_and_paths_are_as_stated? &&
        exactly_two_sets_given?
    end

    def split_into_lengths_and_strings(str)
      str.split("\n").partition { |el| el =~ /^[[:digit:]]$/ }
    end

    def map_input_type_to_qty_provided
      %i(patterns paths).zip(raw_lengths).to_h
    end

    def exactly_two_sets_given?
      raw_lengths.count == 2
    end

    def total_number_of_patterns_and_paths_are_as_stated?
      @raw_inputs.count == raw_lengths.reduce(:+)
    end
  end
end
