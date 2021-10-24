defmodule Nap.Serializer do
  def encode!(v) do
    v |> Nap.JsonTerm.encode!() |> Jason.encode!()
  end

  def decode!(v) do
    v |> Jason.decode!() |> Nap.JsonTerm.decode!()
  end
end
