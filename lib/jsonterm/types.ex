defmodule JsonTerm.Types do
  @types [
    json_term: "jt",
    list: "l",
    atom: "a",
    tuple: "t",
    datetime: "dtz",
    naive_datetime: "dt",
    map: "m",
    dictionary: "di",
    decimal: "de",
    term: "te",
    binary: "b",
    struct: "s",
    date: "d",
    time: "ti",
    set: "se",
    range: "r"
  ]

  # check if type names and symbols are unique
  MapSet.new(@types, &elem(&1, 0)) |> MapSet.size() == length(@types) ||
    raise "type names are not unique"

  MapSet.new(@types, &elem(&1, 1)) |> MapSet.size() == length(@types) ||
    raise "symbols are not unique"

  def types, do: @types

  defmacro __using__(_opts \\ []) do
    Enum.each(JsonTerm.Types.types(), fn {type, symbol} ->
      Module.put_attribute(__CALLER__.module, :"#{type}_type", symbol)
    end)
  end
end
