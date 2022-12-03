defmodule D1Test do
    use ExUnit.Case

    test "p1" do
      assert D1.p1("test/d1_input.txt") == 72478
    end

    test "p2" do
        assert D1.p2("test/d1_input.txt") == 210367
      end
  end
