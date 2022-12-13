defmodule D9 do
  def p1(file) do
    {_h, _t, visited, _} =
    file
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(fn line ->
      [dir, count] = String.split(line, " ")
      {dir, String.to_integer(count)}
    end)
    |> handle_moves
    Enum.count(visited)
  end

  def p2(file) do
    file
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(fn line ->
      [dir, count] = String.split(line, " ")
      {dir, String.to_integer(count)}
    end)
    |> handle_moves_p2
    |> Enum.count()
  end


  defp handle_moves_p2(moves) do
    knots = List.duplicate({0, 0}, 10)
    handle_moves_p2(moves, knots)
  end


  defp handle_moves_p2(moves, [h8, h9]) do
    {_new_h1, _new_h2, visited, h9_moves} = handle_moves(moves, h8, h9, [{0, 0}], [])
    IO.inspect "h9_moves = #{inspect h9_moves}"
    visited
  end
  defp handle_moves_p2(moves, [h1, h2 | knots]) do
    {_, _new_h2, _, h2_moves} = handle_moves(moves, h1, h2, [{0, 0}], [])
    IO.inspect "h2_moves = #{inspect h2_moves}"
    handle_moves_p2(h2_moves, [h2 | knots])
  end


  defp handle_moves(moves) do
    handle_moves(moves, {0, 0}, {0, 0}, [{0, 0}], [])
  end


  defp handle_moves([], h, t, visited, t_moves) do
    {h, t, Enum.uniq(visited), t_moves}
  end

  defp handle_moves([{_, 0} | moves], h, t, visited, t_moves) do
    handle_moves(moves, h, t, visited, t_moves)
  end

  defp handle_moves([{dir, count} | moves], {h_x, h_y}, {t_x, t_y}, visited, t_moves) do
    {{new_h_x, new_h_y}, {new_t_x, new_t_y}} =
      case dir do
        "D" ->
          new_h_x = h_x
          new_h_y = h_y - 1

          new_t_y =
            cond do
              t_y > (new_h_y + 1) -> t_y - 1
              true -> t_y
            end

            new_t_x =
            cond do
              (t_x != h_x) and (t_y != h_y) and (t_y != new_h_y) and (t_x < new_h_x) -> t_x + 1
              (t_x != h_x) and (t_y != h_y) and (t_y != new_h_y) and (t_x > new_h_x) -> t_x - 1
              true -> t_x
            end

          {{new_h_x, new_h_y}, {new_t_x, new_t_y}}

        "U" ->
          new_h_x = h_x
          new_h_y = h_y + 1

          new_t_y =
            cond do
              t_y < (new_h_y - 1) -> t_y + 1
              true -> t_y
            end

          new_t_x =
            cond do
              (t_x != h_x) and (t_y != h_y) and (t_y != new_h_y) and (t_x < new_h_x) -> t_x + 1
              (t_x != h_x) and (t_y != h_y) and (t_y != new_h_y) and (t_x > new_h_x) -> t_x - 1
              true -> t_x
            end

            {{new_h_x, new_h_y}, {new_t_x, new_t_y}}

        "L" ->
          new_h_x = h_x - 1
          new_h_y = h_y

          new_t_x =
            cond do
              t_x > (new_h_x + 1) -> t_x - 1
              true -> t_x
            end

            new_t_y =
            cond do
              (t_x != h_x) and (t_y != h_y) and (t_x != new_h_x) and (t_y < new_h_y) -> t_y + 1
              (t_x != h_x) and (t_y != h_y) and (t_x != new_h_x) and (t_y > new_h_y) -> t_y - 1
              true -> t_y
            end

            {{new_h_x, new_h_y}, {new_t_x, new_t_y}}

        "R" ->
            new_h_x = h_x + 1
            new_h_y = h_y

            new_t_x =
            cond do
              t_x < (new_h_x - 1) -> t_x + 1
              true -> t_x
            end

            new_t_y =
            cond do
              (t_x != h_x) and (t_y != h_y) and (t_x != new_h_x) and (t_y < new_h_y) -> t_y + 1
              (t_x != h_x) and (t_y != h_y) and (t_x != new_h_x) and (t_y > new_h_y) -> t_y - 1
              true -> t_y
            end

            {{new_h_x, new_h_y}, {new_t_x, new_t_y}}

        # "UL" ->
        #     new_h_x = h_x - 1
        #     new_h_y = h_y - 1

        # "UR" ->
        # "DL" ->
        # "DR" ->
      end

      t_dir_move_x = cond do
        new_t_x > t_x -> "R"
        new_t_x < t_x -> "L"
        true -> ""
      end

      t_dir_move_y = cond do
        new_t_y > t_y -> "U"
        new_t_y < t_y -> "D"
        true -> ""
      end

      new_t_moves = cond do
        (t_dir_move_x == "") and (t_dir_move_y) == "" -> t_moves
        true -> [{t_dir_move_y <> t_dir_move_x, 1} | t_moves]
      end

    handle_moves([{dir, count - 1} | moves], {new_h_x, new_h_y}, {new_t_x, new_t_y}, [{new_t_x, new_t_y} | visited], new_t_moves)
  end
end
