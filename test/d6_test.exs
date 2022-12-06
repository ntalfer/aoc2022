defmodule D6Test do
    use ExUnit.Case

    test "p1" do
      assert D6.p1("test/d6_input.txt") == 1093
    end

    test "p2" do
      assert D6.p2("test/d6_input.txt") == 3534
    end
  end
