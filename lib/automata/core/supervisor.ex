defmodule Automata.Supervisor do
  use Supervisor

  def start_link(trees_config) do
    Supervisor.start_link(__MODULE__, trees_config, name: __MODULE__)
  end

  def init(trees_config) do
    children = [
      {Automata.AutomataSupervisor, []},
      {Automata.Server, [trees_config]}
    ]

    opts = [
      strategy: :one_for_all,
      max_restart: 1,
      max_time: 3600,
      extra_arguments: [trees_config]
    ]

    Supervisor.init(children, opts)
  end
end
