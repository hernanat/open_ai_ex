defmodule OpenAI.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    application_config = Application.get_env(:open_ai, :application, [])
    children = Keyword.get(application_config, :children, [])

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: OpenAI.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
