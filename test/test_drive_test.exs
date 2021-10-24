defmodule NapTestDriveTest do
  use ExUnit.Case, async: true
  use Nap.TestCase

  defmodule MyStruct, do: defstruct(a: nil, b: nil)

  test "normal ExUnit test" do
    assert 1 == 1
  end

  napshot "nap snapshot test case" do
    assert 1 == 1
    assert_nap(currnap, 100)
    assert_nap(currnap, 10.0)
    assert_nap(currnap, %{a: 2})
    assert_nap(currnap, {:also, :with, "tuples"})
    assert_nap(currnap, "string")
    assert_nap(currnap, %{a: "long
    multistring
    text

    works fine, too"})
    assert_nap(currnap, %MyStruct{a: 1, b: 2})
  end

  napshot "another nap snapshot test case" do
    assert 1 == 1
    assert_nap(currnap, %{a: 2 + 3})
  end
end
