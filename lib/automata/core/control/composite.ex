# base class for composite behaviors (composed of children)
# class Composite < Behavior
# @children
# def add_child()
# def remove_child()
# def clear_children()

defmodule Composite do
  @moduledoc """
  When a child behavior is complete and returns its status code the Composite
  decides whether to continue through its children or whether to stop there and
  then and return a value.

  The behavior tree represents all possible Actions that your AI can take.
  The route from the top level to each leaf represents one course of action, and
  the behavior tree algorithm traverses among those courses of action in a
  left-to-right manner. In other words, it performs a depth-first traversal.
  """
  @callback add_child() :: {:ok, term} | {:error, String.t()}
  @callback remove_child() :: {:ok, term} | {:error, String.t()}
  @callback clear_children :: {:ok, term} | {:error, String.t()}
end
