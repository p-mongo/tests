defmodule Load do
  
  use Application
  
  # https://stackoverflow.com/questions/30687781/how-to-run-elixir-application
  def start(_type, _args) do
    IO.puts("starting load tester")
    
    {:ok, conn} = Mongo.start_link(url: "mongodb://localhost:34420,localhost:34421,localhost:34422/load?replicaSet=ruby-driver-rs",
    #{:ok, conn} = Mongo.start_link(url: "mongodb://localhost:34420,localhost:34421,localhost:34422/load",
    #{:ok, conn} = Mongo.start_link(database: "load", seeds: ["localhost:34420","localhost:34421","localhost:34422"],
      pool_size: 10)
      
    #IO.inspect(conn)

    #Supervisor.start_link [], strategy: :one_for_one
    Reader.start_link(conn, 1)
    
    receive do
    end
  end
end
