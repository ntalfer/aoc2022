defmodule D9Test do
    use ExUnit.Case

    test "p1" do
      assert D9.p1("test/d9_input_example.txt") == 13
      assert D9.p1("test/d9_input.txt") == 5874
    end

    test "p2" do
     # assert D9.p2("test/d9_input_example.txt") == 1
    #  assert D9.p2("test/d9_input.txt") == "r < 2500"
    end
  end
