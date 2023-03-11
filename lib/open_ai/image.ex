defmodule OpenAI.Image do
  @moduledoc """
  Provides the ability to interact with the OpenAI image generation API.

  See the OpenAI imagess API documentation [here](https://beta.openai.com/docs/api-reference/images/create).
  """

  alias OpenAI.ApiClient

  @resource_path "/images/generations"

  @typedoc """
  Image dimensions accepted by the various image APIs.

  OpenAI API accepts:

  - `256x256`
  - `512x512`
  - `1024x1024`
  """
  @type dimensions :: :"256x256" | :"512x512" | :"1024x1024" | String.t()

  @typedoc """
  The format in which result images are returned.
  """
  @type response_format :: :url | :b64_json

  @typedoc """
  The parameters allowed for `create/3`.

  We make no effort to assign defaults, and so if params are left blank they will
  be set to whatever the OpenAI API defaults are by the server. Consult with the OpenAI
  documentation for more details.

  The parameters are mapped 1:1 with those that OpenAI offers and so
  we do not explain them in detail here.
  """
  @type create_params ::
          {:n, integer()}
          | {:size, dimensions()}
          | {:response_format, response_format()}
          | {:user, String.t()}

  @doc """
  Generate an image given a prompt. Maximum prompt length is 1000 characters.
  """
  @spec create(ApiClient.t(), String.t(), [create_params()]) :: ApiClient.api_result()
  def create(client, prompt, params \\ []),
    do: ApiClient.api_request(client, :post, @resource_path, [{:prompt, prompt} | params])
end
