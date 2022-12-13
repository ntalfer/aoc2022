defmodule D10Test do
    use ExUnit.Case

    test "p1" do
      assert D10.p1("test/d10_input_example.txt") == 13140
      assert D10.p1("test/d10_input.txt") == 12840
    end

    test "p2" do
      assert D10.p2("test/d10_input_example.txt") == :ok
      assert D10.p2("test/d10_input.txt") == :ok
    end
  end
