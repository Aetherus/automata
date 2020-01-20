defmodule Automata do
  @moduledoc """

  """
  use Application
  alias Automata.Automaton

  @timeout 5000

  def start(_type, _args) do
    trees_config = [
      [name: "Automaton1", mfa: {Automaton, :start_link, []}, size: 4],
      [name: "Automaton2", mfa: {Automaton, :start_link, []}, size: 2],
      [name: "Automaton3", mfa: {Automaton, :start_link, []}, size: 1]
    ]

    start_pools(trees_config)
  end

  def start_pools(trees_config) do
    Automata.Supervisor.start_link(trees_config)
  end

  def status(action_name) do
    Automata.Server.status(action_name)
  end
end
