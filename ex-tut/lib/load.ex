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
    
    {:ok, conn} = Mongo.start_link(url: "mongodb://localhost:14420,localhost:14421,localhost:14422/load",
      pool_size: 1000)

    
    Enum.map(1..1000, fn i ->
      spawn_link fn -> read(conn) end
    end)
    
    receive do
    after
      100_000 -> "done"
    end

    Supervisor.start_link [], strategy: :one_for_one
  end
  
  defp read(conn) do
    worker(conn)
    
    read(conn)
  end

  defp worker(conn) do
    # Gets an enumerable cursor for the results
    cursor = Mongo.find(conn, "coll",
      %{"$and" => [%{a: "hello"}]}
    )

    cursor
    |> Enum.to_list()
    |> Enum.count
    |> IO.inspect
  end
end
