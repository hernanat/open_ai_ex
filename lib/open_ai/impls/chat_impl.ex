defmodule OpenAI.ChatImpl do
  @moduledoc false

  alias OpenAI.Behaviours.ChatBehaviour

  @behaviour ChatBehaviour

  @impl ChatBehaviour
  def create_completion(model, messages, params)
      when is_binary(model) and is_list(messages) and is_list(params) do
    OpenAIClient.api_request(:post, "chat/completions", [], [
      {:model, model},
      {:messages, messages} | params
    ])
  end
end
