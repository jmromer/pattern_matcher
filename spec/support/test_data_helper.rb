module TestDataHelper
  def complete_test_data
    [
      '6',
      '*,b,*',
      'a,*,*',
      '*,*,c',
      'foo,bar,baz',
      'w,x,*,*',
      '*,x,y,z',
      '5',
      '/w/x/y/z/',
      'a/b/c',
      'foo/',
      'foo/bar/',
      'foo/bar/baz/'
    ].join("\n")
  end

  def all_patterns
    %w(*,b,* a,*,* *,*,c foo,bar,baz w,x,*,* *,x,y,z)
  end

  def all_paths
    %w(/w/x/y/z/ a/b/c foo/ foo/bar/ foo/bar/baz/)
  end
end
