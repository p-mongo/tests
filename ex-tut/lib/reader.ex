# https://elixir-lang.org/getting-started/processes.html
defmodule Reader do
  def start_link(conn, id, reporter) do
    IO.puts("starting reader #{id}")
    
    Task.start_link(fn -> read(conn, id, reporter) end)
  end
  
  defp read(conn, id, reporter) do
    #IO.write(".")
    
    # Gets an enumerable cursor for the results
    cursor = Mongo.find(conn, "data",
      %{"$and" => [%{counter: 1234}]}
    )
    
    case cursor do
      {:error, error} ->
        #IO.inspect(error)
        
        Load.Statix.increment("read_req.#{id}.error.count")
        Load.Statix.increment("read_req.error.count")
        
        Load.Reporter.fail(reporter)
      _ ->
        #IO.inspect(cursor)
        
        cursor
        |> Enum.to_list()
        |> Enum.count
        
        Load.Reporter.ok(reporter)
        
        Load.Statix.increment("read_req.#{id}.ok.count")
        Load.Statix.increment("read_req.ok.count")
    end
    
    #Load.Statix.increment("read_req", 1, sample_rate: 0.3)
    
    read(conn, id, reporter)
  end
end
