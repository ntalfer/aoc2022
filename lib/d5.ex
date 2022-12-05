defmodule D5 do
  def p1(stacks, file) do
    file
    |> File.read!()
    |> String.split("\n")
    |> Enum.reduce(stacks, &handle_cmd_p1/2)
    |> Map.values
    |> Enum.map(&List.last/1)
    |> Enum.join
  end

  defp handle_cmd_p1(cmd, stacks) do
    ["move", count_str, "from", from_str, "to", to_str] = String.split(cmd)
    count = String.to_integer(count_str)
    from = String.to_integer(from_str)
    to = String.to_integer(to_str)
    move_p1(stacks, count, from, to)
  end

  defp move_p1(stacks, 0, _, _) do
    stacks
  end

  defp move_p1(stacks, count, from, to) do
    [element | elements] = Enum.reverse(stacks[from])
    stacks = %{stacks | from => Enum.reverse(elements), to => stacks[to] ++ [element]}
    move_p1(stacks, count - 1, from, to)
  end

  def p2(stacks, file) do
    file
    |> File.read!()
    |> String.split("\n")
    |> Enum.reduce(stacks, &handle_cmd_p2/2)
    |> Map.values
    |> Enum.map(&List.last/1)
    |> Enum.join
  end

  defp handle_cmd_p2(cmd, stacks) do
    ["move", count_str, "from", from_str, "to", to_str] = String.split(cmd)
    count = String.to_integer(count_str)
    from = String.to_integer(from_str)
    to = String.to_integer(to_str)
    move_p2(stacks, count, from, to)
  end

  defp move_p2(stacks, count, from, to) do
    {bottom, top} = Enum.split(stacks[from], Enum.count(stacks[from]) - count)
    %{stacks | from => bottom, to => stacks[to] ++ top}
  end

end
