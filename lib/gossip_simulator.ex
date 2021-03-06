defmodule GOSSIP do

  use GenServer

  #Client API
  def start_link do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  def read(pid) do
    GenServer.call(pid, {:read})
  end

  def add(pid,item) do
    GenServer.cast(pid, {:add, item})
  end

  # Server API

  def init(:ok) do
    {:ok, []}
  end

  def handle_call({:read}, _from, list) do
    {:reply, list, list}
  end

  def handle_cast({:add, item}, list) do
    {:noreply, list ++ [item]}
  end

  def main(args \\ []) do
    {:ok, pid} = GOSSIP.start_link
    GOSSIP.add(pid,"MY");
    GOSSIP.add(pid,"NAME");
    IO.inspect GOSSIP.read(pid);
    IO.puts "In here"
    IO.inspect pid
  end
end
