defmodule OpenAI.MixProject do
  use Mix.Project

  def project do
    [
      app: :open_ai,
      description: "Elixir wrapper for OpenAI's API.",
      version: "0.1.2",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "OpenAI API Wrapper",
      source_url: "https://github.com/hernanat/open_ai_ex",
      package: package()
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
      {:finch, "~> 0.14"},
      {:hammox, "~> 0.7", only: :test},
      {:jason, "~> 1.3"},
      {:multipart, "~> 0.3"}
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
