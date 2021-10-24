defmodule Nap.Util do
  def module_as_string(module) do
    "#{module}" |> String.replace("Elixir.", "")
  end

  def file_to_tablename(file) do
    String.to_atom(file)
  end

  def filepath_to_nappath(filepath) do
    dirname = Path.dirname(filepath)
    basename = Path.basename(filepath) |> String.replace_suffix(".exs", "")
    Path.join([dirname, "__naps__", basename <> ".nap"])
  end
end
