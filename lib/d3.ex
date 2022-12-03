defmodule D3 do
  def p1(file) do
    file
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(fn line ->
      {str1, str2} = String.split_at(line, div(String.length(line), 2))
      set1 = str1 |> String.codepoints() |> MapSet.new()
      set2 = str2 |> String.codepoints() |> MapSet.new()
      [e] = MapSet.intersection(set1, set2) |> MapSet.to_list()

      e
      |> String.to_charlist()
      |> Enum.at(0)
      |> priority
    end)
    |> Enum.sum()
  end

  def p2(file) do
    file
    |> File.read!()
    |> String.split("\n")
    |> priorities([])
    |> Enum.sum()
  end

  defp priorities([], acc) do
    acc
  end

  defp priorities([elf1, elf2, elf3 | elves], acc) do
    set1 = elf1 |> String.codepoints() |> MapSet.new()
    set2 = elf2 |> String.codepoints() |> MapSet.new()
    set3 = elf3 |> String.codepoints() |> MapSet.new()
    [e] = MapSet.intersection(MapSet.intersection(set1, set2), set3)  |> MapSet.to_list()

    p =
      e
      |> String.to_charlist()
      |> Enum.at(0)
      |> priority

    priorities(elves, [p | acc])
  end

  defp priority(e) when e >= ?a and e <= ?z, do: e - ?a + 1
  defp priority(e) when e >= ?A and e <= ?Z, do: e - ?A + 27
end
