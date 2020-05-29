# https://elixir-lang.org/getting-started/processes.html
defmodule Reader
  def start_link(conn) do
    Task.start_link(fn -> read(conn) end)
  end
  
  defp read(conn) do
    # Gets an enumerable cursor for the results
    cursor = Mongo.find(conn, "data",
      %{"$and" => [%{counter: 1234}]}
    )

    cursor
    |> Enum.to_list()
    |> Enum.count
    |> IO.inspect
    
    read(conn)
  end
end
