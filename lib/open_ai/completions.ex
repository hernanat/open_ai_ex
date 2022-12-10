defmodule OpenAI.Completions do
  @moduledoc """
  Provides the ability to interact with the OpenAI completions API.

  See the OpenAI Completions API documentation [here](https://beta.openai.com/docs/api-reference/completions).
  """

  alias OpenAI.Error

  @typedoc """
  The parameters allowed for `create/3`.

  We make no effort to assign defaults, and so if params are left blank they will
  be set to whatever the OpenAI API defaults are by the server. Consult with the OpenAI
  documentation for more details.

  The parameters are mapped 1:1 with those that OpenAI (except for streaming) offers and so
  we do not explain them in detail here.

  *Note*: The `:stream` param is not currently supported.
  """
  @type create_params ::
          {:suffix, binary()}
          | {:max_tokens, integer()}
          | {:temperature, number()}
          | {:top_p, number()}
          | {:n, integer()}
          | {:logprobs, integer()}
          | {:echo, boolean()}
          | {:stop, binary() | list(binary())}
          | {:presence_penalty, number()}
          | {:frequency_penalty, number()}
          | {:best_of, integer()}
          | {:logit_bias, map()}
          | {:user, binary()}

  @doc """
  Create a completion given a prompt(s) and parameters.

  ## Args

    - `prompt` - The prompt to create a completion for.
    - `params` - Keyword list of params. See `t:create_params/0`.
  """
  @spec create(binary(), binary() | [binary()], keyword(create_params())) ::
          {:ok, map()} | {:error, Error.t()}

  def create(model, prompt, params \\ [])

  def create(model, prompt, params)
      when (is_binary(prompt) or is_list(prompt)) and is_list(params) do
    impl().create(model, prompt, params)
  end

  defp impl, do: Application.get_env(:open_ai, :completions_impl, OpenAI.CompletionsImpl)
end
