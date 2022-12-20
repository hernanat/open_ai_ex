defmodule OpenAI.ModerationsImpl do
  @moduledoc false

  alias OpenAI.Behaviours.ModerationsBehaviour

  @behaviour ModerationsBehaviour

  @impl ModerationsBehaviour
  def create(input, params \\ []) when is_binary(input),
    do: OpenAIClient.api_request(:post, :moderations, [], [{:input, input} | params])
end
