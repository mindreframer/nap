defmodule Nap.JsonTerm do
  defdelegate encode!(term), to: Nap.JsonTerm.Encoder
  defdelegate decode!(term), to: Nap.JsonTerm.Decoder
  defdelegate types, to: Nap.JsonTerm.Types
end
