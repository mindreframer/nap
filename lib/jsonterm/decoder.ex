defmodule JsonTerm.Decoder do
  use JsonTerm.Types

  def decode!(json) do
    [@json_term_type, json] = json
    do_decode(json)
  end

  defp do_decode(json)
       when is_number(json) or is_boolean(json) or is_nil(json) or is_binary(json),
       do: json

  defp do_decode([@list_type, json]), do: Enum.map(json, &do_decode/1)
  defp do_decode([@atom_type, atom]), do: String.to_existing_atom(atom)
  defp do_decode([@tuple_type, tuple]), do: tuple |> Enum.map(&do_decode/1) |> List.to_tuple()
  defp do_decode([@binary_type, binary]), do: Base.decode64!(binary)
  defp do_decode([@date_type, date]), do: Date.from_iso8601!(date)
  defp do_decode([@time_type, time]), do: Time.from_iso8601!(time)
  defp do_decode([@naive_datetime_type, ndt]), do: NaiveDateTime.from_iso8601!(ndt)
  # defp do_decode([@decimal_type, decimal]), do: Decimal.new(decimal)
  defp do_decode([@set_type, set]), do: MapSet.new(set)
  defp do_decode([@range_type, [b, e]]), do: b..e

  defp do_decode([@datetime_type, dt]) do
    case DateTime.from_iso8601(dt) do
      {:ok, datetime, _offset} -> datetime
      {:error, error} -> raise error
    end
  end

  defp do_decode([@struct_type, struct, fields]) do
    struct = String.to_existing_atom(struct)
    fields = Enum.map(fields, fn {k, v} -> {String.to_existing_atom(k), do_decode(v)} end)
    # struct!(struct, fields)
    ## we make struct handling less restrictive, to be able to serialize non-existing structs
    Enum.into(fields, %{}) |> Map.put(:__struct__, struct)
  end

  defp do_decode([@map_type, fields]) do
    Map.new(fields, fn {k, v} -> {String.to_existing_atom(k), do_decode(v)} end)
  end

  defp do_decode([@dictionary_type, fields]) do
    Map.new(fields, fn [k, v] -> {do_decode(k), do_decode(v)} end)
  end

  defp do_decode([@term_type, term]) do
    term
    |> Base.decode64!()
    |> :erlang.binary_to_term()
  end
end
