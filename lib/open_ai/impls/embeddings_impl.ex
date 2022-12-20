defmodule OpenAI.EmbeddingsImpl do
  @moduledoc false

  alias OpenAI.Behaviours.EmbeddingsBehaviour

  @behaviour EmbeddingsBehaviour

  @impl EmbeddingsBehaviour
  def create(model, input, params \\ [])
      when is_binary(model) and (is_binary(input) or is_list(input)) and is_list(params),
      do:
        OpenAIClient.api_request(:post, :embeddings, [], [
          {:model, model},
          {:input, input} | params
        ])
end
