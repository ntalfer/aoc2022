defmodule D3Test do
    use ExUnit.Case

    test "p1" do
      assert D3.p1("test/d3_input.txt") == 8394
    end

    test "p2" do
      assert D3.p2("test/d3_input.txt") == 2413
    end
  end
