defmodule OpenAI.Behaviours.FilesBehaviour do
  alias OpenAI.Error

  @callback list() :: {:ok, map()} | {:error, Error.t()}
  @callback upload(binary(), binary()) :: {:ok, map()} | {:error, Error.t()}
  @callback delete(binary()) :: {:ok, map()} | {:error, Error.t()}
  @callback retrieve(binary()) :: {:ok, map()} | {:error, Error.t()}
  @callback retrieve_content(binary()) :: {:ok, map()} | {:error, Error.t()}
end
