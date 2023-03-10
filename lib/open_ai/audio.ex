defmodule OpenAI.Audio do
  @moduledoc """
  Provides the ability to interact with the OpenAI audio API.

  See the OpenAI Completions API documentation [here](https://beta.openai.com/docs/api-reference/audio).
  """

  alias OpenAI.Error

  @typedoc """
  The parameters allowed for `create_transcription/3`.

  We make no effort to assign defaults, and so if params are left blank they will
  be set to whatever the OpenAI API defaults are by the server. Consult with the OpenAI
  documentation for more details.

  The parameters are mapped 1:1 with those that OpenAI offers and so we do not explain
  them in detail here.
  """

  @type create_transcription_params ::
          {:prompt, binary()}
          | {:response_format, binary()}
          | {:temperature, number()}
          | {:language, binary()}

  @typedoc """
  The parameters allowed for `create_translation/3`.

  We make no effort to assign defaults, and so if params are left blank they will
  be set to whatever the OpenAI API defaults are by the server. Consult with the OpenAI
  documentation for more details.

  The parameters are mapped 1:1 with those that OpenAI offers and so we do not explain
  them in detail here.
  """

  @type create_translation_params ::
          {:prompt, binary()}
          | {:response_format, binary()}
          | {:temperature, number()}

  @doc """
  Create a transcription given an audio file and parameters.

  ## Args

    - `model` - The OpenAI model to use to create the transcription.
    - `file` - The audio file.
    - `params` - Keyword list of params. See `t:create_transcription_params/0`.
  """

  @spec create_transcription(binary(), binary(), [create_transcription_params()]) ::
          {:ok, map()} | {:error, Error.t()}
  def create_transcription(model, file, params \\ [])

  def create_transcription(model, file, params) when is_binary(file),
    do: impl().create_transcription(model, file, params)

  defp impl, do: Application.get_env(:open_ai, :audio_impl, OpenAI.AudioImpl)

  @doc """
  Create a translation given an audio file and parameters.

  ## Args

    - `model` - The OpenAI model to use to create the translation.
    - `file` - The audio file.
    - `params` - Keyword list of params. See `t:create_translation_params/0`.
  """

  @spec create_translation(binary(), binary(), [create_translation_params()]) ::
          {:ok, map()} | {:error, Error.t()}
  def create_translation(model, file, params \\ [])

  def create_translation(model, file, params) when is_binary(file),
    do: impl().create_translation(model, file, params)
end
