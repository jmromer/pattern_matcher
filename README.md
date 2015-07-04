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

Design Notes
-------------

I favored a test-driven, object-oriented design, because that's what I do for a
living.
