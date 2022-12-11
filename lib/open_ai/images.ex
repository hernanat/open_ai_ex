defmodule OpenAI.Images do
  @moduledoc """
  Provides the ability to interact with the OpenAI imagess API.

  See the OpenAI imagess API documentation [here](https://beta.openai.com/docs/api-reference/imagess).
  """
  alias OpenAI.Error

  @typedoc """
  Images dimensions accepted by the images API.

  OpenAI API accepts:

  - `256x256`
  - `512x512`
  - `1024x1024`
  """
  @type dimensions :: :"256x256" | :"512x512" | :"1024x1024" | binary()

  @typedoc """
  The format in which generated images are returned.
  """
  @type response_format :: :url | :b64_json

  @typedoc """
  The parameters allowed for `generate/2`.

  We make no effort to assign defaults, and so if params are left blank they will
  be set to whatever the OpenAI API defaults are by the server. Consult with the OpenAI
  documentation for more details.

  The parameters are mapped 1:1 with those that OpenAI offers and so
  we do not explain them in detail here.
  """
  @type generate_params ::
          {:n, integer()} | {:size, dimensions()} | {:response_format, response_format()} | {:user, binary()}

  @doc """
  Generate an image given a prompt. Maximum prompt length is 1000 characters.
  """
  @spec generate(binary(), [generate_params()]) :: {:ok, [map()]} | {:error, Error.t()}
  def generate(prompt, params \\ []) when is_binary(prompt) and is_list(params),
    do: impl().generate(prompt, params)

  defp impl, do: Application.get_env(:open_ai, :images_impl, OpenAI.ImagesImpl)
end
