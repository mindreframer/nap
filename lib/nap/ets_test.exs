defmodule Nap.EtsTest do
  use ExUnit.Case

  describe "all" do
    test "all" do
      table = :mytest
      Nap.Ets.reset_table(table)
      Nap.Ets.put(table, {:first, 1}, "value")
      assert Nap.Ets.get(table, {:first, 1}) == {:ok, "value"}
      assert Nap.Ets.get(table, {:first, 2}) == {:error, nil}
    end
  end
end
