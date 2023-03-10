defmodule OpenAI.Chat do
  @moduledoc """
  Provides the ability to interact with the OpenAI chat API.

  See the OpenAI Chat API documentation [here](https://platform.openai.com/docs/api-reference/chat).
  """

  alias OpenAI.Error

  @typedoc """
  The parameters allowed for `create_completion/3`.

  We make no effort to assign defaults, and so if params are left blank they will
  be set to whatever the OpenAI API defaults are by the server. Consult with the OpenAI
  documentation for more details.

  The parameters are mapped 1:1 with those that OpenAI (except for streaming) offers and so
  we do not explain them in detail here.

  *Note*: The `:stream` param is not currently supported.
  """
  @type create_completion_params ::
          {
            {:max_tokens, integer()}
            | {:temperature, number()}
            | {:top_p, number()}
            | {:n, integer()}
            | {:stop, binary() | list(binary())}
            | {:presence_penalty, number()}
            | {:frequency_penalty, number()}
            | {:logit_bias, map()}
            | {:user, binary()}
          }
  @typedoc """
  The role of a `t:message/0`.
  """
  @type message_role :: :system | :user | :assistant

  @typedoc """
  Message used in creating chat completions.
  """
  @type message :: %{role: message_role(), content: String.t()}

  @doc """
  Creates a chat completion given messages and paramters.

  ## Args

    - `model` - The OpenAI model used to create the chat completion.
    - `messages` - The messages to generate chat completions for, in the OpenAI
      chat format. See `t:message/0`.
    - `params` - Keyword list of params. See `t:create_completion_params/0`.

  See [here](https://platform.openai.com/docs/guides/chat/introduction) for information
  on the chat completions message format.
  """
  @spec create_completion(binary(), [message()], [create_completion_params()]) ::
          {:ok, map()} | {:error, Error.t()}
  def create_completion(model, messages, params \\ [])

  def create_completion(model, messages, params)
      when is_binary(model) and is_list(messages) and is_list(params) do
    impl().create_completion(model, messages, params)
  end

  defp impl, do: Application.get_env(:open_ai, :chat_completions_impl, OpenAI.ChatImpl)
end
