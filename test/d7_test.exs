defmodule D7Test do
  use ExUnit.Case

  test "p1" do
    assert D7.p1("test/d7_input_example.txt") == 95437
    assert D7.p1("test/d7_input.txt") == 1_307_902
  end

  test "p2" do
    assert D7.p2("test/d7_input_example.txt") == 24_933_642
    assert D7.p2("test/d7_input.txt") == 7068748
  end
end
