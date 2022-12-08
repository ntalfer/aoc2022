defmodule D8 do
  def p1(file) do
    lines =
      file
      |> File.read!()
      |> String.split("\n")

    size = Enum.count(lines)

    lines
    |> Enum.with_index()
    |> Enum.reduce(%{}, &build_map/2)
    |> count_visible_trees(size, 2 * size + 2 * (size - 2))
  end

  def p2(file) do
    lines =
      file
      |> File.read!()
      |> String.split("\n")

    size = Enum.count(lines)

    lines
    |> Enum.with_index()
    |> Enum.reduce(%{}, &build_map/2)
    |> scenic_scores(size)
    |> Enum.max()
  end

  defp build_map({line, y}, acc) do
    line
    |> String.split("", trim: true)
    |> Enum.with_index()
    |> Enum.reduce(acc, fn {value, x}, acc2 -> Map.put(acc2, {x, y}, String.to_integer(value)) end)
  end

  defp count_visible_trees(map, size, count) do
    ref = :counters.new(1, [])
    :counters.put(ref, 1, count)

    for x <- 1..(size - 2), y <- 1..(size - 2) do
      incr =
        cond do
          is_visible(:top, map, x, y, size) -> 1
          is_visible(:left, map, x, y, size) -> 1
          is_visible(:right, map, x, y, size) -> 1
          is_visible(:bottom, map, x, y, size) -> 1
          true -> 0
        end

      :counters.add(ref, 1, incr)
    end

    :counters.get(ref, 1)
  end

  defp is_visible(:top, map, tree_x, tree_y, _size) do
    height = Map.get(map, {tree_x, tree_y})

    0..(tree_y - 1)
    |> Enum.all?(fn y -> Map.get(map, {tree_x, y}) < height end)
  end

  defp is_visible(:bottom, map, tree_x, tree_y, size) do
    height = Map.get(map, {tree_x, tree_y})

    (tree_y + 1)..(size - 1)
    |> Enum.all?(fn y -> Map.get(map, {tree_x, y}) < height end)
  end

  defp is_visible(:left, map, tree_x, tree_y, _size) do
    height = Map.get(map, {tree_x, tree_y})

    0..(tree_x - 1)
    |> Enum.all?(fn x -> Map.get(map, {x, tree_y}) < height end)
  end

  defp is_visible(:right, map, tree_x, tree_y, size) do
    height = Map.get(map, {tree_x, tree_y})

    (tree_x + 1)..(size - 1)
    |> Enum.all?(fn x -> Map.get(map, {x, tree_y}) < height end)
  end

  defp scenic_scores(map, size) do
    Enum.map(map, &scenic_score(&1, map, size))
  end

  ########### /3

  defp scenic_score(tree, map, size) do
    Enum.reduce([:top, :bottom, :left, :right], 1, fn from, acc ->
      acc * scenic_score(from, tree, map, size)
    end)
  end

  ########### /4

  defp scenic_score(:top, {{x, y}, height}, map, size) do
    scenic_score(:top, height, map, size, 0, x, y - 1)
  end

  defp scenic_score(:bottom, {{x, y}, height}, map, size) do
    scenic_score(:bottom, height, map, size, 0, x, y + 1)
  end

  defp scenic_score(:left, {{x, y}, height}, map, size) do
    scenic_score(:left, height, map, size, 0, x-1, y)
  end

  defp scenic_score(:right, {{x, y}, height}, map, size) do
    scenic_score(:right, height, map, size, 0, x+1, y)
  end

  ########### /7

  defp scenic_score(_, _, _, size, score, x, y) when y < 0 or x < 0 or x >= size or y >= size do
    score
  end

  defp scenic_score(:top, height, map, size, score, x, y) do
    case Map.get(map, {x, y}) do
      h when h < height -> scenic_score(:top, height, map, size, score + 1, x, y - 1)
      _ -> score + 1
    end
  end

  defp scenic_score(:bottom, height, map, size, score, x, y) do
    case Map.get(map, {x, y}) do
      h when h < height -> scenic_score(:bottom, height, map, size, score + 1, x, y + 1)
      _ -> score + 1
    end
  end

  defp scenic_score(:left, height, map, size, score, x, y) do
    case Map.get(map, {x, y}) do
      h when h < height -> scenic_score(:left, height, map, size, score + 1, x-1, y)
      _ -> score + 1
    end
  end

  defp scenic_score(:right, height, map, size, score, x, y) do
    case Map.get(map, {x, y}) do
      h when h < height -> scenic_score(:right, height, map, size, score + 1, x+1, y)
      _ -> score + 1
    end
  end
end
