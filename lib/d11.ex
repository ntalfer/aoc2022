defmodule Monkey do
  defstruct id: -1, items: [], op: nil, test: nil, inspected: 0, prime: nil
end

defmodule D11 do
  def p1(monkeys) do
    play(monkeys, :p1, 0, 1, 20)
    |> Map.values()
    |> Enum.map(& &1.inspected)
    |> Enum.sort(fn a, b -> a > b end)
    |> Enum.take(2)
    |> Enum.reduce(1, &Kernel.*/2)
  end

  def p2(monkeys) do
    modulo =
      monkeys
      |> Map.values()
      |> Enum.map(& &1.prime)
      |> Enum.reduce(1, &Kernel.*/2)

    play(monkeys, {:p2, modulo}, 0, 1, 10000)
    |> Map.values()
    |> Enum.map(& &1.inspected)
    |> Enum.sort(fn a, b -> a > b end)
    |> Enum.take(2)
    |> Enum.reduce(1, &Kernel.*/2)
  end

  defp play(monkeys, _, _, round, max_rounds) when round > max_rounds do
    monkeys
  end

  defp play(monkeys, part, index, round, max_rounds) when index >= map_size(monkeys) do
    play(monkeys, part, 0, round + 1, max_rounds)
  end

  defp play(monkeys, part, index, round, max_rounds) do
    # IO.puts "round #{round}/#{max_rounds}"
    monkey = Map.get(monkeys, index, max_rounds)

    case monkey.items do
      [] ->
        play(monkeys, part, index + 1, round, max_rounds)

      [item | items] ->
        new_monkey = %Monkey{monkey | items: items, inspected: monkey.inspected + 1}

        new_item =
          case part do
            :p1 -> div(monkey.op.(item), 3)
            {:p2, modulo} -> rem(monkey.op.(item), modulo)
          end

        new_owner_index = monkey.test.(new_item)
        # IO.puts "monkey #{index} throws #{new_item} to monkey #{new_owner_index}"
        # IO.inspect(monkeys)
        new_monkeys1 = Map.update!(monkeys, index, fn _ -> new_monkey end)
        # IO.inspect(new_monkeys1)

        new_monkeys2 =
          Map.update!(new_monkeys1, new_owner_index, fn m ->
            %Monkey{m | items: m.items ++ [new_item]}
          end)

        play(new_monkeys2, part, index, round, max_rounds)
    end
  end
end
