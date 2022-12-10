defmodule OpenAI.Behaviours.CompletionsBehaviour do
  alias OpenAI.Error
  alias OpenAI.Completions

  @callback create(binary(), binary() | [binary()], keyword(Completions.create_params())) ::
              {:ok, map()} | {:error, Error.t()}
end
