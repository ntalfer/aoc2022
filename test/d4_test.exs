defmodule D4Test do
    use ExUnit.Case

    test "p1" do
      assert D4.p1("test/d4_input.txt") == 560
    end

    test "p2" do
      assert D4.p2("test/d4_input.txt") == 839
    end
  end
