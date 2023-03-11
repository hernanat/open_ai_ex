defmodule OpenAI.ImageVariation do
  @moduledoc """
  Provides the ability to interact with the OpenAI image variations API.

  See the OpenAI imagess API documentation [here](https://beta.openai.com/docs/api-reference/images/create-variation).
  """
  alias OpenAI.ApiClient
  alias OpenAI.Image

  @resource_path "/images/variations"

  @typedoc """
  The parameters allowed for `create/3`.

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
  Creates a variation of a given image.
  """
  @spec create(ApiClient.t(), String.t(), [create_params()]) :: ApiClient.api_result()
  def create(client, image, params \\ []) do
    ApiClient.multipart_api_request(client, :post, @resource_path, [{:image, image} | params])
  end
end
