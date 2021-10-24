# Nap

[Jest](https://jestjs.io/) - inspired snapshotting test package for Elixir. It's quite general and can be used for all snapshotting purposes, not just for REST API testing.

Features:

- frictionless setup
- succinct and minimal API without much cognitive overhead (`napshot` / `assert_nap(currnap, YOURVALUE)`)
- no need to provide explicit snapshot file names
- support for all basic Elixir/Erlang data structures (PIDs, functions, file handles, etc not supported)
- support for multiple snapshot assertions per test case
- support for interactive snapshot updates, to keep your test maintenance minimal
- snapshots are stored in plain-text, so Git diffing is supported
- the overhead compared to manual inline assertions is quite low, in synthetic benchmarks I had numbers of roughly 2-4x slower (if your test suite is dominated by comparisons of static values)
-

## Example

```elixir
defmodule NapTestDriveTest do
  use ExUnit.Case, async: true
  use Nap.TestCase

  defmodule MyStruct, do: defstruct a: nil, b: nil

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

```

## Tutorial

```
# run with interactive snapshot update (blocks for user input)
## with async tests the STDOUT is messed up... Not sure, how to approach it properly

$ nap_interactive=true mix test / nap_i=true mix test

# update all mismatching snapshots
$ nap_update=true mix test / nap_u=true mix test

# plain run, fails on mismatching snapshots
$ mix test
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `nap` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:nap, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/nap](https://hexdocs.pm/nap).

### Todo

- [ ] support ignored possibly nested keys in maps
- [ ] support updating all snapshots without interactive confirmation

### Inspiration

- https://github.com/sb8244/elixir_response_snapshot
- https://github.com/jfrolich/snapshot
- https://github.com/sebastiandedeyne/snapshots
- https://github.com/dczajkowski/snapshy
- https://github.com/derekkraan/walkman/blob/master/lib/walkman/tape.ex

### Links

- [JSON Lines](https://jsonlines.org/)
- [Json Term Elixir Package](https://github.com/kaaboaye/json_term)
- [ETS](https://elixirschool.com/en/lessons/storage/ets)
- [The New Scalable ETS ordered_set](https://blog.erlang.org/the-new-scalable-ets-ordered_set/)
- [A simple streamable binary-serialization container format based on Erlang's External Term Format](https://github.com/tsutsu/etfs/tree/master/lib)
