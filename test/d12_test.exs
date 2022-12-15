defmodule D12Test do
    use ExUnit.Case

    test "p1" do
      assert D12.p1("test/d12_input_example.txt") == 31
      assert D12.p1("test/d12_input.txt") == 425
    end

    test "p2" do
      assert D12.p2("test/d12_input_example.txt") == 29
      assert D12.p2("test/d12_input.txt") == 418
    end
  end
