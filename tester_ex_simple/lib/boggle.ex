defmodule Boggle do
  @moduledoc """
    Add your boggle function below. You may add additional helper functions if you desire.
    Test your code by running 'mix test' from the tester_ex_simple directory.
  """

  def boggle(board, words) do
    word_lengths = words |> Enum.map(&String.length/1)
    start_of_word = word_adder(words)
    word_set = words |> MapSet.new()

    search_board(board, start_of_word, word_set, word_lengths)
  end

  defp search_board(board, start_of_word, word_set, word_lengths) do
    {num_rows, num_cols} = {tuple_size(board), tuple_size(elem(board, 0))}
    Enum.reduce(0..num_rows - 1, %{}, fn row, cur_res ->
      Enum.reduce(0..num_cols - 1, cur_res, fn col, cur_res_inner ->
        explore_cell(board, row, col, "", %{}, start_of_word, word_set, word_lengths, cur_res_inner, [])
      end)
    end)
    |> Enum.map(fn {word, coords} -> {word, Enum.reverse(coords)} end)
    |> Enum.into(%{})
  end

  defp explore_cell(board, row, col, start, curVisited, start_of_word, word_set, word_lengths, cur_res, curPath) do
    case {Map.get(curVisited, {row, col}), row, col} do
      {true, _, _} -> cur_res
      {_, row, col} when row < 0 or col < 0 or row >= tuple_size(board) or col >= tuple_size(elem(board, 0)) -> cur_res
      _ ->
        new_start = start <> elem(elem(board, row), col)
        visited = Map.put(curVisited, {row, col}, true)
        path = [{row, col} | curPath]
        res =
          if MapSet.member?(word_set, new_start),
            do: Map.put(cur_res, new_start, path),
            else: cur_res

        if Map.has_key?(start_of_word, new_start) do
          offsets = for dx <- [-1, 0, 1], dy <- [-1, 0, 1], not (dx == 0 && dy == 0), do: {dx, dy}
          Enum.reduce(offsets, res, fn {dx, dy}, cur_res1 ->
            explore_cell(board, row + dx, col + dy, new_start, visited, start_of_word, word_set, word_lengths, cur_res1, path)
          end)
        else
          res
        end
    end
  end

  defp word_adder(words) do
    Enum.reduce(words, %{}, fn word, cur_res ->
      word_add_help(word, cur_res)
    end)
  end

  defp word_add_help(word, cur_res) do
    Enum.reduce(1..String.length(word), cur_res, fn index, cur_res_inner ->
      start = String.slice(word, 0..(index - 1))
      Map.put(cur_res_inner, start, true)
    end)
  end
end
