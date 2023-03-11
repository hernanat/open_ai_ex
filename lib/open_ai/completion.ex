defmodule OpenAI.Completion do
  @moduledoc """
  Provides the ability to interact with the OpenAI completions API.

  See the OpenAI Completions API documentation [here](https://beta.openai.com/docs/api-reference/completions).
  """

  alias OpenAI.ApiClient

  @resource_path "/completions"

  @typedoc """
  The parameters allowed for `create/4`.

  We make no effort to assign defaults, and so if params are left blank they will
  be set to whatever the OpenAI API defaults are by the server. Consult with the OpenAI
  documentation for more details.

  The parameters are mapped 1:1 with those that OpenAI offers and so we do not explain
  them in detail here.
  """
  @type create_params ::
          {:suffix, String.t()}
          | {:max_tokens, integer()}
          | {:temperature, number()}
          | {:top_p, number()}
          | {:n, integer()}
          | {:logprobs, integer()}
          | {:echo, boolean()}
          | {:stop, String.t() | list(String.t())}
          | {:presence_penalty, number()}
          | {:frequency_penalty, number()}
          | {:best_of, integer()}
          | {:logit_bias, map()}
          | {:user, String.t()}

  @doc """
  Create a completion given a prompt(s) and parameters.

  ## Args

    - `model` - The OpenAI model to use to create the completion.
    - `prompt` - The prompt to create a completion for.
    - `params` - Keyword list of params. See `t:create_params/0`.
  """
  @spec create(ApiClient.t(), String.t(), String.t() | [String.t()], [create_params()]) ::
          ApiClient.api_result()
  def create(client, model, prompt, params \\ [])

  def create(client, model, prompt, params) do
    ApiClient.api_request(client, :post, @resource_path, [
      {:model, model},
      {:prompt, prompt} | params
    ])
  end
end
