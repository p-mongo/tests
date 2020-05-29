# https://elixir-lang.org/getting-started/processes.html
defmodule Reader do
  def start_link(conn, id) do
    IO.puts("starting reader #{id}")
    
    Task.start_link(fn -> read(conn, id) end)
  end
  
  defp read(conn, id) do
    #IO.write(".")
    
    # Gets an enumerable cursor for the results
    cursor = Mongo.find(conn, "data",
      %{"$and" => [%{counter: 1234}]}
    )
    
    case cursor do
      {:error, error} ->
          IO.inspect(error)
          
          Load.Statix.increment("read_req.#{id}.error.count")
          Load.Statix.increment("read_req.error.count")
      _ ->
          cursor
          |> Enum.to_list()
          |> Enum.count
          #|> IO.inspect
          
          Load.Statix.increment("read_req.#{id}.ok.count")
          Load.Statix.increment("read_req.ok.count")
    end
    
    #Load.Statix.increment("read_req", 1, sample_rate: 0.3)
    
    read(conn, id)
  end
end
