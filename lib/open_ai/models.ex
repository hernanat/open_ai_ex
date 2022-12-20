defmodule OpenAI.Models do
  @moduledoc """
  Provides functions for listing and retrieving OpenAI models.

  See OpenAI Models API documentation [here](https://beta.openai.com/docs/api-reference/models).
  """

  alias OpenAI.Error

  @doc """
  Lists all available OpenAI models.
  """
  @spec list() :: {:ok, map()} | {:error, Error.t()}
  def list, do: impl().list()

  @doc """
  Retrieves the model with the given ID.
  """
  @spec get(binary()) :: {:ok, map()} | {:error, Error.t()}
  def get(id), do: impl().get(id)

  defp impl, do: Application.get_env(:open_ai, :models_impl, OpenAI.ModelsImpl)
end
