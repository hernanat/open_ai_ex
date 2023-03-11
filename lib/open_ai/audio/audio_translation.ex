defmodule OpenAI.AudioTranslation do
  @moduledoc """
  Provides the ability to interact with the OpenAI audio translation API.

  See the OpenAI audio translations API documentation [here](https://beta.openai.com/docs/api-reference/audio/create).
  """

  alias OpenAI.ApiClient

  @resource_path "/audio/translations"

  @typedoc """
  The parameters allowed for `create/4`.

  We make no effort to assign defaults, and so if params are left blank they will
  be set to whatever the OpenAI API defaults are by the server. Consult with the OpenAI
  documentation for more details.

  The parameters are mapped 1:1 with those that OpenAI offers and so we do not explain
  them in detail here.
  """

  @type create_params ::
          {:prompt, String.t()}
          | {:response_format, String.t()}
          | {:temperature, number()}

  @doc """
  Create a translation given an audio file and parameters.

  ## Args

    - `model` - The OpenAI model to use to create the translation.
    - `file` - The audio file.
    - `params` - Keyword list of params. See `t:create_params/0`.
  """
  @spec create(ApiClient.t(), String.t(), String.t(), [create_params()]) :: ApiClient.api_result()
  def create(client, model, file, params \\ []) do
    ApiClient.multipart_api_request(client, :post, @resource_path, [
      {:model, model},
      {:file, file} | params
    ])
  end
end
