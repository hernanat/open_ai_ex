defmodule OpenAI.Behaviours.EmbeddingsBehaviour do
  alias OpenAI.Error
  alias OpenAI.Embeddings

  @callback create(binary(), binary() | [binary()], [Embeddings.create_params()]) ::
              {:ok, map()} | {:error, Error.t()}
end
