defmodule D11Test do
  use ExUnit.Case

  defp example_input do
    %{
      0 => %Monkey{
        id: 0,
        items: [79, 98],
        op: fn w -> w * 19 end,
        prime: 23,
        test: &if(rem(&1, 23) == 0, do: 2, else: 3)
      },
      1 => %Monkey{
        id: 1,
        items: [54, 65, 75, 74],
        op: fn w -> w + 6 end,
        prime: 19,
        test: fn w ->
          case rem(w, 19) do
            0 -> 2
            _ -> 0
          end
        end
      },
      2 => %Monkey{
        id: 2,
        items: [79, 60, 97],
        op: fn w -> w * w end,
        prime: 13,
        test: fn w ->
          case rem(w, 13) do
            0 -> 1
            _ -> 3
          end
        end
      },
      3 => %Monkey{
        id: 3,
        items: [74],
        op: fn w -> w + 3 end,
        prime: 17,
        test: fn w ->
          case rem(w, 17) do
            0 -> 0
            _ -> 1
          end
        end
      }
    }
  end

  defp input do
    %{
      0 => %Monkey{
        id: 0,
        items: [64],
        op: fn w -> w * 7 end,
        prime: 13,
        test: fn w ->
          case rem(w, 13) do
            0 -> 1
            _ -> 3
          end
        end
      },
      1 => %Monkey{
        id: 1,
        items: [60, 84, 84, 65],
        op: fn w -> w + 7 end,
        prime: 19,
        test: fn w ->
          case rem(w, 19) do
            0 -> 2
            _ -> 7
          end
        end
      },
      2 => %Monkey{
        id: 2,
        items: [52, 67, 74, 88, 51, 61],
        op: fn w -> w * 3 end,
        prime: 5,
        test: fn w ->
          case rem(w, 5) do
            0 -> 5
            _ -> 7
          end
        end
      },
      3 => %Monkey{
        id: 3,
        items: [67, 72],
        op: &(&1 + 3),
        prime: 2,
        test: fn w ->
          case rem(w, 2) do
            0 -> 1
            _ -> 2
          end
        end
      },
      4 => %Monkey{
        id: 4,
        items: [80, 79, 58, 77, 68, 74, 98, 64],
        op: &(&1 * &1),
        prime: 17,
        test: fn w ->
          case rem(w, 17) do
            0 -> 6
            _ -> 0
          end
        end
      },
      5 => %Monkey{
        id: 5,
        items: [62, 53, 61, 89, 86],
        op: &(&1 + 8),
        prime: 11,
        test: fn w ->
          case rem(w, 11) do
            0 -> 4
            _ -> 6
          end
        end
      },
      6 => %Monkey{
        id: 6,
        items: [86, 89, 82],
        op: &(&1 + 2),
        prime: 7,
        test: fn w ->
          case rem(w, 7) do
            0 -> 3
            _ -> 0
          end
        end
      },
      7 => %Monkey{
        id: 7,
        items: [92, 81, 70, 96, 69, 84, 83],
        op: &(&1 + 4),
        prime: 3,
        test: fn w ->
          case rem(w, 3) do
            0 -> 4
            _ -> 5
          end
        end
      }
    }
  end

  test "p1" do
    assert D11.p1(example_input()) == 10605
    assert D11.p1(input()) == 55216
  end

   test "p2" do
     assert D11.p2(example_input()) == 2713310158
     assert D11.p2(input()) == 12848882750
   end
end
