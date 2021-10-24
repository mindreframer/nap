defmodule Nap do
  @moduledoc """
  Documentation for `Nap`.
  """
  def dump(table, file) do
    Nap.Ets.Dumper.dump(table, file)
  end

  def load(table, file) do
    Nap.Ets.Loader.load(table, file)
  end

  def get(table, module, testname, snapindex) do
    Nap.DB.get(table, module, testname, snapindex)
  end

  def put(table, module, testname, snapindex, value) do
    Nap.DB.put(table, module, testname, snapindex, value)
  end

  def cache_put(k, v) do
    Nap.Ets.Cache.put(k, v)
  end

  def cache_get(k, default \\ nil) do
    Nap.Ets.Cache.get(k, default)
  end
end
