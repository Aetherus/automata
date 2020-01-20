defmodule AutomataTest do
  use ExUnit.Case
  doctest Automata
  alias Automata.Action

  test "greets the world" do
    trees_config = [
      [name: "Automaton1", mfa: {Automaton, :start_link, []}, size: 4],
      [name: "Automaton2", mfa: {Automaton, :start_link, []}, size: 2],
      [name: "Automaton3", mfa: {Automaton, :start_link, []}, size: 1]
    ]

    assert Automata.start_pools(trees_config)
  end
end
