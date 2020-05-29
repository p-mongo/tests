defmodule Load do
  
  use Application
  
  # https://stackoverflow.com/questions/30687781/how-to-run-elixir-application
  def start(_type, _args) do
    IO.puts("starting load tester")
    
    {:ok, conn} = Mongo.start_link(url: "mongodb://localhost:34420,localhost:34421,localhost:34422/load",
      pool_size: 10)

    #Supervisor.start_link [], strategy: :one_for_one
    Reader.start_link(conn)
    
    receive do
    end
  end

  def omit(conn) do
    write_many(conn)
    
    receive do
    after
      100_000 -> "done"
    end

    Supervisor.start_link [], strategy: :one_for_one
  end
  
  defp read_many(conn) do
    Enum.map(1..1000, fn i ->
      spawn_link fn -> read(conn) end
    end)
  end
  
  defp write_many(conn) do
    Enum.map(1..20, fn i ->
      spawn_link fn -> write(conn) end
    end)
  end
  
  defp read(conn) do
    read_worker(conn)
    
    read(conn)
  end

  defp read_worker(conn) do
    # Gets an enumerable cursor for the results
    cursor = Mongo.find(conn, "coll",
      %{"$and" => [%{a: "hello"}]}
    )

    cursor
    |> Enum.to_list()
    |> Enum.count
    |> IO.inspect
  end
  
  defp write(conn) do
    write_worker(conn)
    
    write(conn)
  end

  defp write_worker(conn) do
    Mongo.insert_one!(conn, "coll",
      %{a: "hello"},
      w: 1,
    )
  end
end
