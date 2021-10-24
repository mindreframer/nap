defmodule Nap.Ets do
  use GenServer

  @impl true
  def init(arg) do
    {:ok, arg}
  end

  def start_link(arg) do
    GenServer.start_link(__MODULE__, arg, name: __MODULE__)
  end

  @doc """
  reset_table needs to go through GenServer,
    otherwise the ETS table dies after a ExUnit.Case finishes but before being persisted
  """
  def reset_table(table) do
    GenServer.call(__MODULE__, {:reset_table, table})
  end

  @moduledoc """
  Basic abstraction on top of `:ets` module
  """
  def put(table, key, value) when is_atom(table) do
    :ets.insert(table, {key, value})
  end

  def get(table, key, default \\ nil) do
    case :ets.lookup(table, key) do
      [] ->
        cond do
          default == nil -> {:error, nil}
          true -> {:ok, default}
        end

      [{_key, value}] ->
        {:ok, value}
    end
  end

  @impl true
  def handle_call({:reset_table, table}, _from, state) do
    reset_table_private(table)
    {:reply, :ok, state}
  end

  defp reset_table_private(table) do
    if :ets.whereis(table) != :undefined do
      :ets.delete(table)
    end

    opts = [
      :named_table,
      :public,
      :ordered_set,
      read_concurrency: true,
      write_concurrency: true
    ]

    ^table = :ets.new(table, opts)
  end

  def list(table) do
    :ets.tab2list(table)
  end
end
