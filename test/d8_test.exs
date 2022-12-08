defmodule D8Test do
    use ExUnit.Case

    test "p1" do
      assert D8.p1("test/d8_input_example.txt") == 21
      assert D8.p1("test/d8_input.txt") == 1814
    end

    test "p2" do
      assert D8.p2("test/d8_input_example.txt") == 8
      assert D8.p2("test/d8_input.txt") == 330786
    end
  end
