# A Behavior is an abstract interface that can be activated, run,
# and deactivated. Actions provide specific implementations of
# this interface. Branches in the tree can be thought of as high
# level behaviors, heirarchically combining smaller behaviors to
# provide more complex and interesting behaviors

defmodule Behavior do
  # Define behaviours which user modules have to implement, with type annotations
  @callback on_init([]) :: {:ok, term} | {:error, String.t()}
  @callback update() :: atom
  @callback on_terminate(atom) :: atom

  # When you call use in your module, the __using__ macro is called.
  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      # User modules must implement the Filter callbacks
      @behaviour Behavior

      # Define implementation for user modules to use
      @impl Behavior
      def on_init(str) do
        IO.inspect(unquote(opts))

        {:ok, "some url " <> str}
      end

      @impl Behavior
      def update do
        # return status
      end

      def tick(status = :running, arg = "yodle") do
        # put as param after testing
        if status != :running, do: on_init(arg)
        status = update()
        if status != :running, do: on_terminate(status)
        status
      end

      @impl Behavior
      def on_terminate(status) do
        {:ok, status}
      end

      # Defoverridable makes the given functions in the current module overridable
      # Without defoverridable, new definitions of greet will not be picked up
      defoverridable on_init: 1, update: 0, on_terminate: 1, tick: 2
    end
  end
end

# user-defined actions
defmodule ChildBehavior1 do
  use Behavior,
    type: :sequence,
    children: []

  def update do
    {:ok, "overrides update/0"}
  end
end

defmodule ChildBehavior2 do
  use Behavior
end
