defmodule OpenAI.Behaviours.ModelsBehaviour do
  alias OpenAI.Error

  @callback list() :: {:ok, [map()]} | {:error, Error.t()}
  @callback get(binary()) :: {:ok, map()} | {:error, Error.t()}
end
