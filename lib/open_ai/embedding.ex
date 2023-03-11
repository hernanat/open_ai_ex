defmodule OpenAI.Embedding do
  @moduledoc """
  Provides the ability to interact with the OpenAI embeddings API.

  See the OpenAI embeddings API documentation [here](https://beta.openai.com/docs/api-reference/embeddings).
  """

  alias OpenAI.ApiClient

  @resource_path "/embeddings"

  @typedoc """
  The parameters allowed for `create/4`.

  We make no effort to assign defaults, and so if params are left blank they will
  be set to whatever the OpenAI API defaults are by the server. Consult with the OpenAI
  documentation for more details.

  The parameters are mapped 1:1 with those that OpenAI offers and so we do not explain
  them in detail here.
  """
  @type create_params :: {:user, String.t()}

  @doc """
  Creates an embedding vector representing the input text.

  Max input length is 8192 tokens.
  """
  @spec create(ApiClient.t(), String.t(), String.t() | [String.t()], [create_params()]) ::
          ApiClient.api_result()
  def create(client, model, input, params \\ []) do
    ApiClient.api_request(client, :post, @resource_path, [
      {:model, model},
      {:input, input} | params
    ])
  end
end
