defmodule D5Test do
  use ExUnit.Case

  @stacks %{
    1 => ["N", "R", "G", "P"],
    2 => ["J", "T", "B", "L", "F", "G", "D", "C"],
    3 => ["M", "S", "V"],
    4 => ["L", "S", "R", "C", "Z", "P"],
    5 => ["P", "S", "L", "V", "C", "W", "D", "Q"],
    6 => ["C", "T", "N", "W", "D", "M", "S"],
    7 => ["H", "D", "G", "W", "P"],
    8 => ["Z", "L", "P", "H", "S", "C", "M", "V"],
    9 => ["R", "P", "F", "L", "W", "G", "Z"]
  }

  @example %{1 => ["Z", "N"], 2 => ["M", "C", "D"], 3 => ["P"]}

  test "p1" do
    assert D5.p1(@example, "test/d5_example_input.txt") == "CMZ"
    assert D5.p1(@stacks, "test/d5_input.txt") == "VPCDMSLWJ"
  end

  test "p2" do
    assert D5.p2(@example, "test/d5_example_input.txt") == "MCD"
    assert D5.p2(@stacks, "test/d5_input.txt") == "TPWCGNCCG"
  end
end
