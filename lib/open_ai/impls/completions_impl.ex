defmodule OpenAI.CompletionsImpl do
  @moduledoc false

  alias OpenAI.Behaviours.CompletionsBehaviour

  @behaviour CompletionsBehaviour

  @impl CompletionsBehaviour
  def create(model, prompt, params)
      when (is_binary(prompt) or is_list(prompt)) and is_list(params) do
    OpenAIClient.api_request(:post, :completions, [], [
      {:model, model},
      {:prompt, prompt} | params
    ])
  end
end
