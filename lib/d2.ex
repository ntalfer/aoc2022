defmodule D2 do

    @rock1 "A"
    @paper1 "B"
    @scissors1 "C"

    @rock2 "X"
    @paper2 "Y"
    @scissors2 "Z"

    @loose "X"
    @draw "Y"
    @win "Z"

  def p1(file) do
    file
    |> get_rounds
    |> play_p1(0)
  end

  def get_rounds(file) do
    file
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(&String.split(&1, " "))
  end

  def p2(file) do
    file
    |> get_rounds
    |> play_p2(0)
  end

  defp play_p1([], score) do
    score
  end

  defp play_p1([[him, me] | rounds], score) do
    incr = play_round_p1(him, me)
    play_p1(rounds, score + incr)
  end

  defp play_round_p1(@rock1, @rock2), do: 3 + 1
  defp play_round_p1(@paper1, @paper2), do: 3 + 2
  defp play_round_p1(@scissors1, @scissors2), do: 3 + 3
  defp play_round_p1(@paper1, @rock2), do: 1
  defp play_round_p1(@scissors1, @paper2), do: 2
  defp play_round_p1(@rock1, @scissors2), do: 3
  defp play_round_p1(_, @rock2), do: 6 + 1
  defp play_round_p1(_, @paper2), do: 6 + 2
  defp play_round_p1(_, @scissors2), do: 6 + 3

  defp play_p2([], score) do
    score
  end

  defp play_p2([[him, action] | rounds], score) do
    incr = play_round_p2(him, action)
    play_p2(rounds, score + incr)
  end
#Rock defeats Scissors, Scissors defeats Paper, and Paper defeats Rock.

  def play_round_p2(@rock1, @loose), do: 3
  def play_round_p2(@rock1, @draw), do: 1 + 3
  def play_round_p2(@rock1, @win), do: 6 + 2
  def play_round_p2(@paper1, @loose), do: 1
  def play_round_p2(@paper1, @draw), do: 2 + 3
  def play_round_p2(@paper1, @win), do: 6 + 3
  def play_round_p2(@scissors1, @loose), do: 2
  def play_round_p2(@scissors1, @draw), do: 3 + 3
  def play_round_p2(@scissors1, @win), do: 6 + 1
end
