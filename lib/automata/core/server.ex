defmodule Automata.Server do
  use GenServer
  use DynamicSupervisor

  #######
  # API #
  #######

  def start_link(trees_config) do
    GenServer.start_link(__MODULE__, trees_config, name: __MODULE__)
  end

  def status(tree_name) do
    Automata.AutomatonServer.status(tree_name)
  end

  #############
  # Callbacks #
  #############

  def init(trees_config) do
    trees_config
    |> Enum.each(fn tree_config ->
      send(self, {:start_tree, tree_config})
    end)

    {:ok, trees_config}
  end

  def handle_info({:start_tree, tree_config}, state) do
    {:ok, _tree_sup} =
      DynamicSupervisor.start_child(
        Automata.AutomataSupervisor,
        {Automata.AutomatonSupervisor, [tree_config]}
      )

    {:noreply, state}
  end

  #####################
  # Private Functions #
  #####################

  def child_spec([trees_config]) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [trees_config]},
      restart: :temporary,
      shutdown: 10000,
      type: :worker
    }
  end
end
