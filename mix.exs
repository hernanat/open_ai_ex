defmodule OpenAI.MixProject do
  use Mix.Project

  def project do
    [
      app: :open_ai,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
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
      {:finch, "~> 0.14"},
      {:ex_doc, "~> 0.29", only: :dev, runtime: false}
    ]
  end
end
