defmodule D4 do
  def p1(file) do
    file
    |> File.read!()
    |> String.split("\n")
    |> Enum.filter(fn line ->
        line
        |> String.split([",", "-"])
        |> Enum.map(&String.to_integer/1)
        |> overlap_p1?
    end)
    |> Enum.count
  end

  def overlap_p1?([s1, e1, s2, e2]) do
    set1 = MapSet.new(s1..e1)
    set2 = MapSet.new(s2..e2)
    intersection = MapSet.intersection(set1, set2)
    MapSet.equal?(intersection, set1) or MapSet.equal?(intersection, set2)
  end

  def p2(file) do
    file
    |> File.read!()
    |> String.split("\n")
    |> Enum.filter(fn line ->
        line
        |> String.split([",", "-"])
        |> Enum.map(&String.to_integer/1)
        |> overlap_p2?
    end)
    |> Enum.count
  end

  def overlap_p2?([s1, e1, s2, e2]) do
    set1 = MapSet.new(s1..e1)
    set2 = MapSet.new(s2..e2)
    intersection = MapSet.intersection(set1, set2)
    MapSet.size(intersection) > 0
  end
end
