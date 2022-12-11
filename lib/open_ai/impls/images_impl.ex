defmodule OpenAI.ImagesImpl do
  @moduledoc false

  alias OpenAI.Behaviours.ImagesBehaviour

  @behaviour ImagesBehaviour

  @impl ImagesBehaviour
  def generate(prompt, params \\ []) when is_binary(prompt) and is_list(params),
    do: OpenAIClient.api_request(:post, "images/generations", [], [{:prompt, prompt} | params])
end
