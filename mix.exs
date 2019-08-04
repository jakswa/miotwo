defmodule Miotwo.Mixfile do
  use Mix.Project

  def project do
    [
      app: :miotwo,
      version: "0.0.1",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Miotwo.Application, []},
      extra_applications: [:logger, :runtime_tools, :httpoison, :timex, :scout_apm]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.3.0"},
      {:phoenix_pubsub, "~> 1.0"},
      {:gettext, "~> 0.11"},
      {:cowboy, "~> 1.0"},
      {:httpoison, "~> 0.13"},
      {:cors_plug, "~> 1.2"},
      {:distillery, "~> 1.5"},
      {:exvcr, "~> 0.10", only: :test},
      {:timex, "~> 3.1"},
      {:rollbax, ">= 0.0.0"},
      {:scout_apm, "~> 0.0"}
    ]
  end
end
