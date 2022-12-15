defmodule D10 do
  def p1(file) do
    {reg, cycles} =
      file
      |> File.read!()
      |> String.split("\n")
      |> Enum.reduce({1, []}, &handle_line/2)

    cycles = cycles ++ [reg]

    20 * Enum.at(cycles, 20 - 1) + 60 * Enum.at(cycles, 60 - 1) + 100 * Enum.at(cycles, 100 - 1) +
      140 * Enum.at(cycles, 140 - 1) + 180 * Enum.at(cycles, 180 - 1) +
      220 * Enum.at(cycles, 220 - 1)
  end

  def p2(file) do
    {reg, cycles} =
      file
      |> File.read!()
      |> String.split("\n")
      |> Enum.reduce({1, []}, &handle_line/2)

    cycles = cycles ++ [reg]

    grid =
      Enum.reduce(0..39, %{}, fn x, acc ->
        Enum.reduce(0..5, acc, fn y, acc2 ->
          Map.put(acc2, {x, y}, ".")
        end)
      end)

    grid = draw(grid, cycles, 0)

    # IO.puts ""
    # 0..5
    # |> Enum.each(fn y ->
    #     IO.inspect Enum.reduce(0..39, "", fn x, acc -> acc <> Map.get(grid, {x, y}) end)
    # end)

    :ok
  end

  defp draw(grid, [x|cycles], n) when n < (6*40) do
            cond do
                (rem(n, 40) == (x - 1)) or (rem(n, 40) == x) or (rem(n, 40) == (x + 1)) ->
                    new_grid = Map.put(grid, {rem(n, 40), div(n, 40)}, "#")
                    draw(new_grid, cycles, n + 1)
                true ->
                    draw(grid, cycles, n + 1)
            end
  end
  defp draw(grid, _, _), do: grid

  defp handle_line("noop", {reg, cycles}) do
    {reg, cycles ++ [reg]}
  end

  defp handle_line("addx " <> count_str, {reg, cycles}) do
    count = String.to_integer(count_str)
    add_cycles = List.duplicate(reg, 2)
    {reg + count, cycles ++ add_cycles}
  end
end
