defmodule OpenAI.MixProject do
  use Mix.Project

  def project do
    [
      app: :open_ai,
      description: "Elixir wrapper for OpenAI's API.",
      version: "0.1.3",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "OpenAI API Wrapper",
      source_url: "https://github.com/hernanat/open_ai_ex",
      package: package(),
      docs: [
        main: "readme",
        extras: ["README.md"]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {OpenAI.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.29", only: :dev, runtime: false},
      {:tesla, "~> 1.5"},

      # http clients
      {:ibrowse, "4.4.0", optional: true},
      {:hackney, "~> 1.6", optional: true},
      {:gun, "~> 1.3", optional: true},
      {:finch, "~> 0.13", optional: true},
      {:castore, "~> 0.1 or ~> 1.0", optional: true},

      # json parsers
      {:jason, ">= 1.0.0", optional: true},
      {:poison, ">= 1.0.0", optional: true},
      {:exjsx, ">= 3.0.0", optional: true},
      {:mint, "~> 1.0", optional: true},

      # testing
      {:hammox, "~> 0.7", only: :test}
    ]
  end

  defp package do
    [
      name: "open_ai",
      files: ["lib", "config", "mix.exs", "README*", "LICENSE.md"],
      licenses: ["MIT"],
      links: %{
        GitHub: "https://github.com/hernanat/open_ai_ex"
      }
    ]
  end
end
