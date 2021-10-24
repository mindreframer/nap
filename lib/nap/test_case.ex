defmodule Nap.TestCase do
  alias Nap.Util

  defmacro __using__(_) do
    quote do
      @nap_flag_update Nap.Config.nap_update()
      @nap_flag_verbose Nap.Config.nap_verbose()
      @nap_flag_interactive Nap.Config.nap_interactive()

      @nap_file Util.filepath_to_nappath(__ENV__.file)
      @nap_table Util.file_to_tablename(__ENV__.file)
      @mod_string Util.module_as_string(__MODULE__)

      require Nap.TestCase
      import Nap.TestCase

      setup_all do
        Nap.load(@nap_table, @nap_file)

        on_exit(fn ->
          ## if dirty!
          if Nap.cache_get({@nap_table, :dirty}) do
            if @nap_flag_verbose do
              IO.puts("DUMPING #{@nap_table}")
            end

            Nap.dump(@nap_table, @nap_file)
          end
        end)

        :ok
      end
    end
  end

  require ExUnit.Assertions

  defmacro assert_nap(testname, actual_value, comment \\ "") do
    quote do
      module = @mod_string
      comment = unquote(comment)
      testname = unquote(testname)
      snapindex = Nap.cache_get({module, testname}, 0)

      with {:ok, stored_value} <- Nap.get(@nap_table, module, testname, snapindex) do
        realvalue = unquote(actual_value)

        if stored_value != realvalue && @nap_flag_interactive do
          Nap.cache_put({@nap_table, :dirty}, true)

          interactive_assertion(
            @nap_table,
            module,
            testname,
            snapindex,
            comment,
            stored_value,
            realvalue
          )
        else
          assert stored_value == unquote(actual_value)
        end
      else
        _ ->
          Nap.cache_put({@nap_table, :dirty}, true)
          Nap.put(@nap_table, module, testname, snapindex, unquote(actual_value))
      end

      Nap.cache_put({module, testname}, snapindex + 1)
    end
  end

  def interactive_assertion(
        nap_table,
        module,
        testname,
        snapindex,
        _comment,
        stored_value,
        actual_value
      ) do
    {error, _stack} =
      try do
        ExUnit.Assertions.assert(stored_value == actual_value)
      rescue
        error -> {error, __STACKTRACE__}
      end

    IO.puts("\nLEFT: stored / RIGHT: actual")
    IO.puts("\nIN #{module} / #{testname} / #{snapindex}")
    ExUnit.Formatter.format_assertion_error(error) |> IO.puts()
    should_update = IO.gets("UPDATE (Y/n)?")

    if String.trim(should_update) in ["", "y", "Y"] do
      Nap.put(nap_table, module, testname, snapindex, actual_value)
    else
      raise error
    end
  end

  defmacro napshot(name, block) do
    quote do
      test unquote(name) do
        var!(currnap) = unquote(name)
        unquote(block)
      end
    end
  end
end
