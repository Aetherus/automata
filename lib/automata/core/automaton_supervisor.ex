defmodule Automata.AutomatonSupervisor do
  use Supervisor

  def start_link(tree_config) do
    Supervisor.start_link(__MODULE__, tree_config, name: :"#{tree_config[:name]}Supervisor")
  end

  def init(tree_config) do
    # No DynamicSupervisor since only one_for_one supported
    opts = [
      strategy: :one_for_all
    ]

    children = [
      {Automata.AutomatonServer, [self, tree_config]}
    ]

    Supervisor.init(children, opts)
  end

  def child_spec(tree_config) do
    %{
      id: :"#{tree_config[:name]}Supervisor",
      start: {__MODULE__, :start_link, tree_config},
      type: :supervisor
    }
  end
end
