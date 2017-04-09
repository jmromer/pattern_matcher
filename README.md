Pattern Matcher
===============

Purpose
-------

A command-line utility that takes input from STDIN in the following format:

```
6
*,b,*
a,*,*
*,*,c
foo,bar,baz
w,x,*,*
*,x,y,z
5
/w/x/y/z/
a/b/c
foo/
foo/bar/
foo/bar/baz/
```

And produces output as follows:

```
*,x,y,z
a,*,*
NO MATCH
NO MATCH
foo,bar,baz
```

Matching each of the given paths (e.g. `/a/b/c`) with the best-fitting pattern that
matches it (e.g. `a,b,c`).


Manual Testing
--------------

```sh
cat data/input.txt | bin/pattern_match
```

Output:

```
*,x,y,z
a,*,*
NO MATCH
NO MATCH
foo,bar,baz
```

Test Suite
----------

```
PatternMatcher::InputParser
  #parse
    given valid input
      correctly parses patterns
      correctly parses paths
      correctly parses the number of patterns and paths
    given invalid input
      raises an error unless the given numbers are valid
      raises an error unless given exactly two digit-lines

PatternMatcher::Analyzer
  #best_fitting_pattern_for
    returns the highest-scoring pattern for a/b/c
    returns the highest-scoring pattern for /w/x/y/z/
    returns the NO MATCH for foo/bar/
    returns the NO MATCH for foo/
    returns the highest-scoring pattern for foo/bar/baz/

PatternMatcher::Pattern
  ::build
    returns an array of Pattern objects
  #to_a
    returns the parsed pattern, as an array
  #pattern
    parses a passed-in pattern string

PatternMatcher::Path
  ::build
    returns an array of Path objects
  #path
    ignores leading and trailing slashes
    parses a passed-in path string
  #to_a
    returns the parsed path, as an array

PatternMatcher::Matcher
  is sortable by pattern string, in descending order by default
  #pattern_string
    returns the pattern as a string
  ::build
    builds a collection of Matcher objects
  #evaluate
    compares a path to a given pattern, yielding a score
    given a 4-segment pattern
      proportionately penalizes score for an unmatched segment
      penalizes half-credit for a wildcard match
    given a 3-segment pattern
      penalizes half-credit for a wildcard match
      proportionately penalizes score for an unmatched segment
      zeroes score for mismatch in number of segments

Finished in 0.02623 seconds (files took 0.49902 seconds to load)
26 examples, 0 failures

Randomized with seed 3352
```
