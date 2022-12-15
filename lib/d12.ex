defmodule D12 do
  def p1(file) do
    str = File.read!(file)
    {dg, start, stop} = build_digraph(str)

    vertices = :digraph.get_short_path(dg, start, stop)
    Enum.count(vertices) - 1
  end

  def p2(file) do
    str = File.read!(file)
    {dg, _start, stop} = build_digraph(str)

    dg
    |> :digraph.vertices
    |> Enum.filter(fn vertice ->
        {_, v} = :digraph.vertex(dg, vertice)
        v == ?a
    end)
    |> Enum.reduce(:infinity, fn vertex, acc ->
        case :digraph.get_short_path(dg, vertex, stop) do
            false ->
                acc
            vertices ->
                sp = Enum.count(vertices) - 1
                min(acc, sp)
        end
    end)
  end

  defp build_digraph(str) do

    {dg, start, stop} =
      str
      |> to_charlist
      |> build_vertices({:digraph.new(), nil, nil}, 0, 0)

    dg =
        dg
        |> :digraph.vertices()
        |> Enum.reduce(dg, &build_edges/2)

    {dg, start, stop}
  end

  defp build_vertices([], result, _, _) do
    result
  end

  defp build_vertices([?\n | values], result, _x, y) do
    build_vertices(values, result, 0, y + 1)
  end

  defp build_vertices([v | values], {dg, start, stop}, x, y) do
    {start, new_v} = case v do
            ?S -> {{x, y}, ?a}
            _ -> {start, v}
    end
    {stop, new_v} = case new_v do
        ?E -> {{x, y}, ?z}
        _ -> {stop, new_v}
    end
    :digraph.add_vertex(dg, {x, y}, new_v)
    build_vertices(values, {dg, start, stop}, x + 1, y)
  end

  defp build_edges({x, y} = vertex, dg) do
    {_, val} = :digraph.vertex(dg, vertex)

      case :digraph.vertex(dg, {x - 1, y}) do
        {_, v} when v <= val + 1 ->
          :digraph.add_edge(dg, vertex, {x - 1, y})

        _ ->
          :ok
      end

      case :digraph.vertex(dg, {x + 1, y}) do
        {_, v} when v <= val + 1 ->
          :digraph.add_edge(dg, vertex, {x + 1, y})

        _ ->
          :ok
      end

      case :digraph.vertex(dg, {x, y - 1}) do
        {_, v} when v <= val + 1 ->
          :digraph.add_edge(dg, vertex, {x, y - 1})

        _ ->
          :ok
      end

      case :digraph.vertex(dg, {x, y + 1}) do
        {_, v} when v <= val + 1 ->
          :digraph.add_edge(dg, vertex, {x, y + 1})

        _ ->
          :ok
      end

      dg
  end
end
