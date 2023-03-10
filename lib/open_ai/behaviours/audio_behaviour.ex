defmodule OpenAI.Behaviours.AudioBehaviour do
  alias OpenAI.Error

  @callback create_transcription(binary(), binary(), [Audio.create_transcription_params()]) ::
              {:ok, map()} | {:error, Error.t()}

  @callback create_translation(binary(), binary(), [Audio.create_translation_params()]) ::
              {:ok, map()} | {:error, Error.t()}
end
