defmodule Nap.Ets.Dumper do
  @batch_size 1000
  def dump(table, filepath) do
    File.rm(filepath)
    {:ok, file} = File.open(filepath, [:append, {:delayed_write, 100, 20}])

    try do
      process(:ets.match(table, {:"$1", :"$2"}, @batch_size), file)
    after
      File.close(file)
    end
  end

  def process({els, cnt}, file) do
    data = Enum.map(els, &transform/1)

    Enum.each(data, &IO.binwrite(file, &1 <> "\n"))
    clean_garbage()
    process(:ets.match(cnt), file)
  end

  def process(:"$end_of_table", _file) do
    # IO.puts("DONE")
  end

  defp transform(el), do: el |> Nap.Serializer.encode!()

  defp clean_garbage do
    Process.list() |> Enum.each(&:erlang.garbage_collect/1)
  end
end
