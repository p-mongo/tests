defmodule Retry do
  
  use Application
  
  # https://stackoverflow.com/questions/30687781/how-to-run-elixir-application
  def start(_type, _args) do
    IO.puts("starting retryer")
    
    {:ok, conn} = Mongo.start_link(url: "mongodb://localhost:14420,localhost:14421,localhost:14422/retry")
    
    write(conn)
  end

  defp write(conn) do
    IO.puts("write")
    
    Mongo.insert_one!(conn, "coll",
      %{a: "hello"},
      w: "majority",
    )
    
    Process.sleep(1000)
    
    write(conn)
  end
end
