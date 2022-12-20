defmodule OpenAI.ImagesImpl do
  @moduledoc false

  alias OpenAI.Behaviours.ImagesBehaviour

  @behaviour ImagesBehaviour

  @impl ImagesBehaviour
  def generate(prompt, params \\ []) when is_binary(prompt) and is_list(params),
    do: OpenAIClient.api_request(:post, "images/generations", [], [{:prompt, prompt} | params])

  @impl ImagesBehaviour
  def edit(prompt, image, params \\ [])
      when is_binary(prompt) and is_binary(image) and is_list(params),
      do:
        OpenAIClient.multipart_api_request(:post, "images/edits", [], [
          {:prompt, prompt},
          {:image, image} | params
        ])
end
