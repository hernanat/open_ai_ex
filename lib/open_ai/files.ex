defmodule OpenAI.Files do
  @moduledoc """
  Provides functions for managing files on OpenAI.

  See OpenAI Files API documentation [here](https://beta.openai.com/docs/api-reference/files).
  """

  alias OpenAI.Error

  @doc """
  Lists files that belong to the user's organization.
  """
  @spec list() :: {:ok, map()} | {:error, Error.t()}
  def list, do: impl().list()

  @doc """
  Uploads a file, maximum 1GB.
  """
  def upload(file, purpose) when is_binary(file) and is_binary(purpose),
    do: impl().upload(file, purpose)

  @doc """
  Deletes the file with the given id.
  """
  def delete(id) when is_binary(id), do: impl().delete(id)

  @doc """
  Retrieve the file with the given id.
  """
  def retrieve(id) when is_binary(id), do: impl().retrieve(id)

  @doc """
  Retrieve the contents of the file with the given id.
  """
  def retrieve_content(id) when is_binary(id), do: impl().retrieve_content(id)

  defp impl, do: Application.get_env(:open_ai, :files_impl, OpenAI.FilesImpl)
end
