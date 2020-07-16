# https://elixir-lang.org/getting-started/processes.html
defmodule Load.Reporter do
  use Agent
  
  def start_link(_opts) do
    IO.puts("starting reporter")
    
    Agent.start_link(fn -> %{ok: 0, fail: 0} end, name: :reporter)
  end
  
  def ok(state) do
    ok_value = Agent.get(state, &Map.get(&1, :ok)) + 1
    
    Agent.update(state, &Map.put(&1, :ok, ok_value))
    
    fail_value = Agent.get(state, &Map.get(&1, :fail))
    IO.write("\rOK: #{ok_value} Fail: #{fail_value}")
    
  end
  
  def fail(state) do
    fail_value = Agent.get(state, &Map.get(&1, :fail)) + 1
    Agent.update(state, &Map.put(&1, :fail, fail_value))
    
    ok_value = Agent.get(state, &Map.get(&1, :ok))
    IO.write("\rOK: #{ok_value} Fail: #{fail_value}")
  end
end
