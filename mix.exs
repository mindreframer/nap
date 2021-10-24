defmodule Nap.MixProject do
  use Mix.Project

  def project do
    [
      app: :nap,
      version: "0.2.0",
      package: package(),
      description: description(),
      elixir: "~> 1.12",
      test_paths: ["test", "lib"],
      test_pattern: "*_test.exs",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Nap.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.2"},
      {:pathex, "~> 1.2.0"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp description() do
    """
    Nap is a JEST inspired snapshotting test package for Elixir.
    It's quite general and can be used for all snapshotting purposes, not just for REST API testing.
    """
  end

  defp package() do
    [
      # These are the default files included in the package
      files: ["lib", "mix.exs", "README.md", "LICENSE"],
      maintainers: ["Roman Heinrich (mindreframer)"],
      licenses: ["MIT"],
      links: %{"GitHub" => github_url()}
    ]
  end

  defp github_url() do
    "https://github.com/mindreframer/nap"
  end
end
