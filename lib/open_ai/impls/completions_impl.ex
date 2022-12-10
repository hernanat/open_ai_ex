defmodule OpenAI.CompletionsImpl do
  @moduledoc false

  alias OpenAI.Behaviours.CompletionsBehaviour

  @behaviour CompletionsBehaviour

  @impl CompletionsBehaviour
  def create(model, prompt, params)
      when (is_binary(prompt) or is_list(prompt)) and is_list(params) do
    request_body =
      Enum.reduce(params, %{model: model, prompt: prompt}, fn {param, value}, result ->
        Map.put(result, param, value)
      end)

    OpenAIClient.api_request(:post, :completions, [], request_body)
  end
end
