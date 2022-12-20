defmodule OpenAI.Moderations do
  @moduledoc """
  Provides functions for interacting with OpenAI's moderation API.

  See OpenAI Moderations API documentation [here](https://beta.openai.com/docs/api-reference/moderations).
  """

  alias OpenAI.Error

  @type create_params :: {:model, binary()}

  @doc """
  Classifies if text violates OpenAI's Content Policy.
  """
  @spec create(binary(), [create_params()]) :: {:ok, map()} | {:error, Error.t()}
  def create(input, params \\ []) when is_binary(input), do: impl().create(input, params)

  defp impl, do: Application.get_env(:open_ai, :moderations_impl, OpenAI.ModerationsImpl)
end
