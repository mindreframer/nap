defmodule Nap.Serializer do
  def encode!(v) do
    v |> JsonTerm.encode!() |> Jason.encode!()
  end

  def decode!(v) do
    v |> Jason.decode!() |> JsonTerm.decode!()
  end
end
