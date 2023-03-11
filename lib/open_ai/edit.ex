defmodule OpenAI.Edit do
  @moduledoc """
  Provides the ability to interact with the OpenAI edits API.

  See the OpenAI Edits API documentation [here](https://beta.openai.com/docs/api-reference/edits).
  """

  alias OpenAI.ApiClient

  @resource_path "/edits"

  @typedoc """
  The parameters allowed for `create/5`.

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
  """
  @spec create(ApiClient.t(), String.t(), String.t(), String.t(), [create_params()]) ::
          ApiClient.api_result()
  def create(client, model, input, instruction, params \\ [])

  def create(client, model, input, instruction, params) do
    ApiClient.api_request(client, :post, @resource_path, [
      {:model, model},
      {:input, input},
      {:instruction, instruction} | params
    ])
  end
end
