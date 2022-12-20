defmodule OpenAI.Behaviours.FineTunesBehaviour do
  alias OpenAI.Error

  @callback create(binary(), [FineTunes.create_params()]) :: {:ok, map()} | {:error, Error.t()}
  @callback list() :: {:ok, map()} | {:error, Error.t()}
  @callback retrieve(binary()) :: {:ok, map()} | {:error, Error.t()}
  @callback cancel(binary()) :: {:ok, map()} | {:error, Error.t()}
  @callback list_events(binary()) :: {:ok, map()} | {:error, Error.t()}
  @callback delete_model(binary()) :: {:ok, map()} | {:error, Error.t()}
end
