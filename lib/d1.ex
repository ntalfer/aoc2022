defmodule D1 do
  def p1(file) do
    file
    |> elves
    |> Enum.max()
  end

  def p2(file) do
    file
    |> elves
    |> Enum.sort(fn e1, e2 -> e1 > e2 end)
    |> Enum.take(3)
    |> Enum.sum()
  end

  defp elves(file) do
    file
    |> File.read!()
    |> String.split("\n\n")
    |> Enum.map(fn line ->
      line
      |> String.split("\n")
      |> Enum.map(&String.to_integer/1)
      |> Enum.sum()
    end)
  end
end
