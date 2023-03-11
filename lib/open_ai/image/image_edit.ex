defmodule OpenAI.ImageEdit do
  @moduledoc """
  Provides the ability to interact with the OpenAI image editing API.

  See the OpenAI imagess API documentation [here](https://beta.openai.com/docs/api-reference/images/create-edit).
  """
  alias OpenAI.ApiClient
  alias OpenAI.Image

  @resource_path "/images/edits"

  @typedoc """
  The parameters allowed for `create/4`.

  We make no effort to assign defaults, and so if params are left blank they will
  be set to whatever the OpenAI API defaults are by the server. Consult with the OpenAI
  documentation for more details.

  The parameters are mapped 1:1 with those that OpenAI offers and so
  we do not explain them in detail here.
  """
  @type create_params ::
          {:mask, String.t()}
          | {:n, integer()}
          | {:size, Image.dimensions()}
          | {:response_format, Image.response_format()}
          | {:user, String.t()}

  @doc """
  Create an edited or extended image given an original image and a prompt.
  """
  @spec create(ApiClient.t(), String.t(), String.t(), [create_params()]) :: ApiClient.api_result()
  def create(client, prompt, image, params \\ []) do
    ApiClient.multipart_api_request(client, :post, @resource_path, [
      {:prompt, prompt},
      {:image, image} | params
    ])
  end
end
