defmodule JsonTerm do
  defdelegate encode!(term), to: JsonTerm.Encoder
  defdelegate decode!(term), to: JsonTerm.Decoder
  defdelegate types, to: JsonTerm.Types
end
