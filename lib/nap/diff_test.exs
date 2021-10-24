defmodule Nap.DiffTest do
  use ExUnit.Case

  describe "Diff" do
    test "works" do
      Nap.Diff.compare(%{a: 1}, %{b: 3}) |> IO.inspect(label: "maps")
      Nap.Diff.compare(%{a: %{c: 2}, d: %{e: 3, b: %{f: 5}}}, %{a: %{c: 2}, d: %{e: 3, b: %{f: 6}}}) |> IO.inspect(label: "nested maps")
      Nap.Diff.compare("some", "sum") |> IO.inspect(label: "binaries")
      Nap.Diff.compare({:a, 1}, {:a, 2}) |> IO.inspect(label: "tuples")
      Nap.Diff.compare([:a, 1], [:a, 2, 3, 4]) |> IO.inspect(label: "lists")
      Nap.Diff.compare([:a, 2, 3, 4], [:a, 1]) |> IO.inspect(label: "lists")
    end
  end
end
