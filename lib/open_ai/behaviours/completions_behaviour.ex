defmodule OpenAI.Behaviours.CompletionsBehaviour do
  alias OpenAI.Error
  alias OpenAI.Completions

  @callback create(binary(), binary() | [binary()], [Completions.create_params()]) ::
              {:ok, map()} | {:error, Error.t()}
end
