defmodule Nap.DB do
  def get(table, module, testname, snapindex) do
    Nap.Ets.get(table, {module, testname, snapindex})
  end

  def put(table, module, testname, snapindex, value) do
    Nap.Ets.put(table, {module, testname, snapindex}, value)
  end
end
