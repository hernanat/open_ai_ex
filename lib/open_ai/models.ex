defmodule OpenAI.Models do
  @moduledoc """
  Provides functions for listing and retrieving OpenAI models."
  """

  alias OpenAI.Error

  @doc """
  Lists all available OpenAI models.
  """
  @spec list() :: {:ok, [map()]} | {:error, Error.t()}
  def list, do: impl().list()

  @doc """
  Retrieves the model with the given ID. See the OpenAI API docs for more details.
  """
  @spec get(binary()) :: {:ok, map()} | {:error, Error.t()}
  def get(id), do: impl().get(id)

  defp impl do
    Application.get_env(:open_ai, :models_impl, OpenAI.ModelsImpl)
  end
end
