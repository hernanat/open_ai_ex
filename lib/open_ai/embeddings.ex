defmodule OpenAI.Embeddings do
  @moduledoc """
  Provides the ability to interact with the OpenAI embeddings API.

  See the OpenAI embeddings API documentation [here](https://beta.openai.com/docs/api-reference/embeddings).
  """

  alias OpenAI.Error

  @type create_params :: {:user, binary()}

  @doc """
  Creates an embedding vector representing the input text.

  Max input length is 8192 tokens.
  """
  @spec create(binary(), binary() | [binary()], [create_params()]) ::
          {:ok, map()} | {:error, Error.t()}
  def create(model, input, params \\ [])
      when is_binary(model) and (is_binary(input) or is_list(input)) and is_list(params),
      do: impl().create(model, input, params)

  defp impl, do: Application.get_env(:open_ai, :embeddings_impl, OpenAI.EmbeddingsImpl)
end
