defmodule Nap.Ets.Cache do
  use GenServer
  @name :nap_cache_ets

  def init(arg) do
    :ets.new(@name, [
      :set,
      :public,
      :named_table,
      {:read_concurrency, true},
      {:write_concurrency, true}
    ])

    {:ok, arg}
  end

  def start_link(arg) do
    GenServer.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def get(key, default \\ nil) do
    case :ets.lookup(@name, key) do
      [] ->
        default

      [{_key, value}] ->
        value
    end
  end

  def put(key, value) do
    :ets.insert(@name, {key, value})
  end

  def list do
    :ets.tab2list(@name)
  end
end
