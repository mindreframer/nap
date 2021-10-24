defmodule Nap.Ets.Loader do
  def load(table, filepath) do
    assert_file!(filepath)
    Nap.Ets.reset_table(table)

    File.stream!(filepath)
    |> Stream.each(fn line ->
      [key, value] = line |> transform()
      Nap.Ets.put(table, key, value)
    end)
    |> Stream.run()
  end

  defp transform(line) do
    Nap.Serializer.decode!(line)
  end

  defp assert_file!(filepath) do
    File.mkdir_p(Path.dirname(filepath))
    File.touch!(filepath)
  end
end
