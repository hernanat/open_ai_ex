defmodule OpenAI.Edits do
  @moduledoc """
  Provides the ability to interact with the OpenAI edits API.

  See the OpenAI Edits API documentation [here](https://beta.openai.com/docs/api-reference/edits).
  """

  alias OpenAI.Error

  @typedoc """
  The parameters allowed for `create/4`.

  We make no effort to assign defaults, and so if params are left blank they will
  be set to whatever the OpenAI API defaults are by the server. Consult with the OpenAI
  documentation for more details.

  The parameters are mapped 1:1 with those that OpenAI offers and so
  we do not explain them in detail here.
  """
  @type create_params :: {:n, integer()} | {:temperature, number()} | {:top_p, number()}

  @doc """
  Create a edit given a input(s) and parameters.

  ## Args

    - `model` - The OpenAI model to use to create the edit.
    - `input` - The input to create a edit for.
    - `instructions` - The instruction that tells the model how to edit the input.
    - `params` - Keyword list of params. See `t:create_params/0`.

  *NOTE:* At the time of this writing, if you use a model that is not allowed for the edit
  API, OpenAI will return an invalid URL error response, like this:

      OpenAI.Edits.create("text-davinci-001", "how r u?", "correct the spelling mistakes")
      {:error,
       %OpenAI.Error{
         message: "Invalid URL (POST /v1/edits)",
         code: nil,
         param: nil,
         type: "invalid_request_error",
         raw: %{
           "code" => nil,
           "message" => "Invalid URL (POST /v1/edits)",
           "param" => nil,
           "type" => "invalid_request_error"
         }
       }}

  This is a known issue, see [here](https://community.openai.com/t/is-edit-endpoint-documentation-incorrect/23361).
  """
  @spec create(binary(), binary(), binary(), [create_params()]) ::
          {:ok, map()} | {:error, Error.t()}

  def create(model, input, instruction, params \\ [])

  def create(model, input, instruction, params)
      when is_binary(input) and is_binary(instruction) and is_list(params) do
    impl().create(model, input, instruction, params)
  end

  defp impl, do: Application.get_env(:open_ai, :edits_impl, OpenAI.EditsImpl)
end
