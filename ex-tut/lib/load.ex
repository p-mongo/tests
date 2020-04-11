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
    
    # Starts an unpooled connection
    {:ok, conn} = Mongo.start_link(url: "mongodb://localhost:14420/load")

    # Gets an enumerable cursor for the results
    cursor = Mongo.find(conn, "coll", %{})

    cursor
    |> Enum.to_list()
    |> IO.inspect

    Supervisor.start_link [], strategy: :one_for_one
  end
end
