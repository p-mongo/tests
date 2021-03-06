defmodule Load.Supervisor do
  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  @impl true
  def init(:ok) do
    children = [
      Load.Reporter |
      (1..10 |> Enum.map(fn -> {{Reader, [conn, id, reporter]} end))
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
