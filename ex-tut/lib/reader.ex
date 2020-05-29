# https://elixir-lang.org/getting-started/processes.html
defmodule Reader do
  def start_link(conn) do
    IO.puts("starting reader")
    
    Task.start_link(fn -> read(conn) end)
  end
  
  defp read(conn) do
    IO.write(".")
    
    # Gets an enumerable cursor for the results
    cursor = Mongo.find(conn, "data",
      %{"$and" => [%{counter: 1234}]}
    )

    cursor
    |> Enum.to_list()
    |> Enum.count
    #|> IO.inspect
    
    Load.Statix.increment("read_req.count")
    #Load.Statix.increment("read_req", 1, sample_rate: 0.3)
    
    read(conn)
  end
end
