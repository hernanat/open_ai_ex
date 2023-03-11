defmodule OpenAI.ChatCompletion do
  @moduledoc """
  Provides the ability to interact with the OpenAI chat API.

  See the OpenAI Chat API documentation [here](https://platform.openai.com/docs/api-reference/chat).
  """

  alias OpenAI.ApiClient

  @resource_path "/chat/completions"

  @typedoc """
  The parameters allowed for `create/4`.

  We make no effort to assign defaults, and so if params are left blank they will
  be set to whatever the OpenAI API defaults are by the server. Consult with the OpenAI
  documentation for more details.

  The parameters are mapped 1:1 with those that OpenAI offers and so we do not explain
  them in detail here.
  """
  @type create_params ::
          {
            {:max_tokens, integer()}
            | {:temperature, number()}
            | {:top_p, number()}
            | {:n, integer()}
            | {:stop, String.t() | list(String.t())}
            | {:presence_penalty, number()}
            | {:frequency_penalty, number()}
            | {:logit_bias, map()}
            | {:user, String.t()}
          }
  @typedoc """
  The role of a `t:message/0`.
  """
  @type message_role :: :system | :user | :assistant

  @typedoc """
  Message used while creating chat completions.
  """
  @type message :: %{role: message_role(), content: String.t()}

  @doc """
  Creates a chat completion given messages and paramters.

  ## Args

    - `model` - The OpenAI model used to create the chat completion.
    - `messages` - The messages to generate chat completions for, in the OpenAI
      chat format. See `t:message/0`.
    - `params` - Keyword list of params. See `t:create_params/0`.

  See [here](https://platform.openai.com/docs/guides/chat/introduction) for information
  on the chat completions message format.
  """
  @spec create(ApiClient.t(), String.t(), [message()], [create_params()]) ::
          ApiClient.api_result()
  def create(client, model, messages, params \\ [])

  def create(client, model, messages, params) do
    ApiClient.api_request(client, :post, @resource_path, [
      {:model, model},
      {:messages, messages} | params
    ])
  end
end
