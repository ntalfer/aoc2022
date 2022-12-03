defmodule D2Test do
  use ExUnit.Case

  test "p1" do
    assert D2.p1("test/d2_input.txt") == 13809
  end

  test "p2" do
    assert D2.p2("test/d2_input.txt") == 12316
  end
end
