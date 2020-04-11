defmodule Load do
  @moduledoc """
  Documentation for `Load`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Load.hello()
      :world

  """
  def hello do
    :world
  end
  
  use Application
  
  # https://stackoverflow.com/questions/30687781/how-to-run-elixir-application
  def start(_type, _args) do
    IO.puts("starting!")
    Supervisor.start_link [], strategy: :one_for_one
  end
end
