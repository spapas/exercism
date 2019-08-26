defmodule Bowling do
  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game
  """
  use Agent

  @spec start() :: any
  def start do
    # with {:ok, pid} <- Agent.start_link(fn -> [] end), do: pid
    {:ok, pid} = Agent.start_link(fn -> [[frame: 1]] end)
    pid
  end

  @doc """
    Records the number of pins knocked down on a single roll. Returns `any`
    unless there is something wrong with the given number of pins, in which
    case it returns a helpful message.
  """

  @spec roll(any, integer) :: any | String.t()
  def roll(_game, roll) when roll > 10, do: "Pin count exceeds pins on the lane"
  def roll(_game, roll) when roll < 0, do: "Negative roll is invalid"

  # def roll([%{frame: n, roll_number: 1} | _rest] = state, 10),
  #  do: [%{frame: n + 1, roll_number: 1} | state]

  def roll(game, roll) do
    :ok = Agent.update(game, &set_state(&1, roll))
    game
  end

  # 1st roll, strike
  defp set_state([[frame: frame] | rest], roll) when roll == 10,
    do: [[frame: frame + 1] | [[frame: frame, roll1: 10] | rest]]

  # 1st roll, no strike
  defp set_state([[frame: frame] | rest], roll), do: [[frame: frame, roll1: roll] | rest]
  # 2nd roll, error
  defp set_state([[frame: frame, roll1: roll1] | rest], roll) when roll1 + roll > 10,
    do: "Pin count exceeds pins on the lane"

  defp set_state([[frame: frame, roll1: roll1] | rest], roll),
    do: [[frame: frame + 1] | [[frame: frame, roll1: roll1, roll2: roll] | rest]]

  defp set_state([[frame: frame, roll1: roll1, roll2: roll2] | rest] = state, roll) do
    state
  end

  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful message.
  """

  @spec score(any) :: integer | String.t()
  def score(game) do
    Agent.get(game, & &1) |> Enum.reverse() |> Enum.reduce(%{score: 0, p: nil, pp: nil}, &(&1 + &2)) |> Map.get(:score)
  end

  defp score_reducer([frame: _frame, roll1: 10], %{score: score, p: p, pp: pp}), do: %{score: 10+score, p: :strike, pp: p}
  defp score_reducer([frame: _frame, roll1: roll1, roll2: roll1], %{score: score, p: p, pp: pp}) when roll+roll2=10, do: %{score: 10+score, p: :spare, pp: p}
  defp score_reducer([frame: _frame, roll1: roll1, roll2: roll1], %{score: score, p: p, pp: pp}), do: %{score: roll1+roll2+score, p: nil, pp: p}
  #defp score_reducer([frame: _frame, roll1: 10], %{score: score, p: p, pp: pp}), do: %{score: 10+score, p: :strike, pp: p}
end
