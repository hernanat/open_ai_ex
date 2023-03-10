defmodule OpenAI.AudioImpl do
  @moduledoc false

  alias OpenAI.Behaviours.AudioBehaviour

  @behaviour AudioBehaviour

  @impl AudioBehaviour
  def create_transcription(model, file, params) when is_binary(file) do
    OpenAIClient.multipart_api_request(:post, "audio/transcriptions", [], [
      {:model, model},
      {:file, file}
      | params
    ])
  end

  @impl AudioBehaviour
  def create_translation(model, file, params) when is_binary(file) do
    OpenAIClient.multipart_api_request(:post, "audio/translations", [], [
      {:model, model},
      {:file, file}
      | params
    ])
  end
end
