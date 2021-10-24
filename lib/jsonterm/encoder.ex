defmodule JsonTerm.Encoder do
  use JsonTerm.Types

  def encode!(term) do
    encoded = do_encode(term)

    [@json_term_type, encoded]
  end

  defp do_encode(term) when is_number(term) or is_boolean(term) or is_nil(term), do: term
  defp do_encode(term) when is_list(term), do: [@list_type, Enum.map(term, &do_encode/1)]
  defp do_encode(term) when is_atom(term), do: [@atom_type, Atom.to_string(term)]

  defp do_encode(term) when is_tuple(term),
    do: [@tuple_type, term |> Tuple.to_list() |> Enum.map(&do_encode/1)]

  defp do_encode(term) when is_bitstring(term) do
    if String.printable?(term),
      do: term,
      else: [@binary_type, Base.encode64(term)]
  end

  defp do_encode(%Date{} = date), do: [@date_type, Date.to_iso8601(date)]
  defp do_encode(%Time{} = time), do: [@time_type, Time.to_iso8601(time)]

  defp do_encode(%DateTime{} = datetime), do: [@datetime_type, DateTime.to_string(datetime)]

  defp do_encode(%NaiveDateTime{} = datetime),
    do: [@naive_datetime_type, NaiveDateTime.to_string(datetime)]

  # defp do_encode(%Decimal{} = decimal), do: [@decimal_type, Decimal.to_string(decimal)]

  defp do_encode(%Range{} = b..e), do: [@range_type, [b, e]]

  defp do_encode(%MapSet{} = set), do: [@set_type, MapSet.to_list(set)]

  defp do_encode(%struct{} = term) do
    value =
      term
      |> Map.from_struct()
      |> Map.new(fn {k, v} -> {k, do_encode(v)} end)

    [@struct_type, Atom.to_string(struct), value]
  end

  defp do_encode(term) when is_map(term) do
    term = Map.to_list(term)

    if Enum.all?(term, fn {k, _v} -> is_atom(k) end) do
      value = Map.new(term, fn {k, v} -> {k, do_encode(v)} end)
      [@map_type, value]
    else
      value = Enum.map(term, fn {k, v} -> [do_encode(k), do_encode(v)] end)
      [@dictionary_type, value]
    end
  end

  defp do_encode(term), do: [@term_type, term |> :erlang.term_to_binary() |> Base.encode64()]
end
