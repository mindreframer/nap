defmodule Nap.Ets.PersistenceTest do
  use ExUnit.Case

  setup do
    dir = System.tmp_dir!()
    tmp_file = Path.join(dir, "mynap.txt")
    {:ok, %{tmp_file: tmp_file}}
  end

  describe "full cycle" do
    test "works", %{tmp_file: tmp_file} do
      table = :mytest
      filepath = tmp_file
      Nap.Ets.reset_table(table)
      Nap.Ets.put(table, {"MyFirst", "test", 1}, %{a: 1})
      Nap.Ets.put(table, {"MyFirst", "test", 2}, %{a: 2})
      Nap.Ets.put(table, {"MyFirst", "test", 3}, %{a: 3})
      Nap.Ets.put(table, {"MySecond", "test", 1}, %{b: 1})
      Nap.Ets.put(table, {"MySecond", "test", 2}, %{b: 2})

      assert Nap.Ets.get(table, {"MyFirst", "test", 3}) == {:ok, %{a: 3}}

      Nap.Ets.Dumper.dump(table, filepath)

      Nap.Ets.reset_table(table)
      refute Nap.Ets.get(table, {"MyFirst", "test", 3}) == {:ok, %{a: 3}}

      Nap.Ets.Loader.load(table, filepath)
      assert Nap.Ets.get(table, {"MyFirst", "test", 3}) == {:ok, %{a: 3}}
    end
  end
end
