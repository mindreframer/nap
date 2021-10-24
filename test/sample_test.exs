defmodule SampleTest do
  use ExUnit.Case, async: true
  use Nap.TestCase

  defmodule MyStruct do
    defstruct a: nil, b: nil
  end

  test "stest1" do
    assert 1 == 1
    assert %{a: 1} == %{a: 1}
    assert %{a: 2} == %{a: 2}
    assert {:fine, "tuple"} == {:fine, "tuple"}
  end

  test "stest2" do
    assert 1 == 1
    assert %{a: 1} == %{a: 1}
    assert %{a: 2} == %{a: 2}
    assert {:fine, "tuple"} == {:fine, "tuple"}
  end

  test "stest3" do
    assert 1 == 1
    assert %{a: 1} == %{a: 1}
    assert %{a: 2} == %{a: 2}
    assert {:fine, "tuple"} == {:fine, "tuple"}
  end

  test "stest4" do
    assert 1 == 1
    assert %{a: 1} == %{a: 1}
    assert %{a: 2} == %{a: 2}
    assert {:fine, "tuple"} == {:fine, "tuple"}
  end

  napshot "test1" do
    assert 1 == 1
    assert_nap(currnap, %{a: 2})
    assert_nap(currnap, %{a: 2})
    assert_nap(currnap, {:fine, "tuple"})
    assert_nap(currnap, "string")
    assert_nap(currnap, 100)
    assert_nap(currnap, 10.0)
    assert_nap(currnap, %MyStruct{a: 1, b: 10})
  end

  napshot "test2" do
    assert 1 == 1
    assert_nap(currnap, %{a: 1})
    assert_nap(currnap, %{a: 2 + 3})
  end

  napshot "test3" do
    assert 1 == 1
    assert_nap(currnap, %{a: "some
    asn
    asml aslkj

    asdfasd"})
    assert_nap(currnap, %{a: 4})
    assert_nap(currnap, %{a: 2})
    assert_nap(currnap, %{a: 2})
    assert_nap(currnap, %{a: 2})
    assert_nap(currnap, %{a: 2})
    assert_nap(currnap, %{a: 2})
    assert_nap(currnap, %{a: 45})
    assert_nap(currnap, %{a: 30})
    assert_nap(currnap, %{a: 3})
    assert_nap(currnap, %{a: 2})
    assert_nap(currnap, %{a: 2})
    assert_nap(currnap, %{a: 5}, "must be 5")
  end

  napshot "test4" do
    assert 1 == 1
    assert_nap(currnap, %{a: 1})
    assert_nap(currnap, %{a: 2})
    assert_nap(currnap, %{a: 2})
    assert_nap(currnap, %{a: 2})
    assert_nap(currnap, %{a: 2})
    assert_nap(currnap, %{a: 2})
    assert_nap(currnap, %{a: 2})
    assert_nap(currnap, %{a: 45})
    assert_nap(currnap, %{a: 30}, "must be 30")
    assert_nap(currnap, %{a: 544})
    assert_nap(currnap, %{a: 2})
    assert_nap(currnap, %{a: 2})
    assert_nap(currnap, %{a: 5}, "must be 5")
  end
end
