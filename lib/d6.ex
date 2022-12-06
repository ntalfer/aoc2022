defmodule D6 do
  def p1(file) do
    file
    |> File.read!()
    |> analyse(0, 4)
  end

  def p2(file) do
    file
    |> File.read!()
    |> analyse(0, 14)
  end

  defp analyse(str, index, count) do
    {left, right} = Enum.split(to_charlist(str), count)

    case Enum.count(Enum.uniq(left)) do
      ^count ->
        index + count

      _ ->
        [_ | rest] = left
        analyse(to_string(rest ++ right), index + 1, count)
    end
  end
end
