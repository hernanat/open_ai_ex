defmodule OpenAI.ModelsImpl do
  @moduledoc false

  alias OpenAI.Behaviours.ModelsBehaviour

  @behaviour ModelsBehaviour

  @impl ModelsBehaviour
  def list, do: OpenAIClient.api_request(:get, :models)

  @impl ModelsBehaviour
  def get(id), do: OpenAIClient.api_request(:get, "models/#{id}")
end
