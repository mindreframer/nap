defmodule Nap.UtilTest do
  use ExUnit.Case
  alias Nap.Util

  describe "filepath_to_nappath" do
    test "works" do
      assert Util.filepath_to_nappath("/a/b/c/some_test.exs") == "/a/b/c/__naps__/some_test.nap"
    end
  end
end
