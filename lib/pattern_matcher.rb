require 'pattern_matcher/version'

module PatternMatcher
  # parses user input from STDIN
  class InputParser; end

  # parses a pattern string into its constituent segments
  class Pattern; end

  # parses a path string into its constituent segments
  class Path; end

  # evaluates the goodness of a match between a path and a given pattern
  class Matcher; end

  # finds the best-fitting pattern for a given path
  class Analyzer; end
end

require 'pattern_matcher/input_parser'
require 'pattern_matcher/pattern'
require 'pattern_matcher/path'
require 'pattern_matcher/matcher'
require 'pattern_matcher/analyzer'
