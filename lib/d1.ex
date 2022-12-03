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
    input = File.read!(file)

    Regex.split(~r{\n\n}, input)
    |> Enum.map(fn line ->
      Regex.split(~r{\n}, line)
      |> Enum.map(&String.to_integer/1)
      |> Enum.sum()
    end)
  end
end
