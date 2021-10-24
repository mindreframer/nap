defmodule Nap.SerializerTest do
  use ExUnit.Case
  alias Nap.Serializer

  test "works" do
    res = {:a, %{b: 1}, [1, 2, 3], ~D[2021-10-23]}
    assert Serializer.encode!(res) |> Serializer.decode!() == res
  end

  test "works with double-encoding" do
    orig = {:a, %{b: 1}, [1, 2, 3], ~D[2021-10-23]}
    res = orig |> Serializer.encode!()
    assert Serializer.encode!(res) |> Serializer.decode!() == res
    assert Serializer.encode!(res) |> Serializer.decode!() |> Serializer.decode!() == orig
  end
end
