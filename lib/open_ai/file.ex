defmodule OpenAI.File do
  @moduledoc """
  Provides functions for managing files on OpenAI.

  See OpenAI Files API documentation [here](https://beta.openai.com/docs/api-reference/files).
  """

  alias OpenAI.ApiClient

  @resource_path "/files"

  @typedoc """
  The purpose of a file upload.
  """
  @type upload_purpose :: :"fine-tune" | String.t()

  @doc """
  Lists files that belong to the user's organization.
  """
  @spec list(ApiClient.t()) :: ApiClient.api_result()
  def list(client), do: ApiClient.api_request(client, :get, @resource_path)

  @doc """
  Uploads a file, maximum 1GB.
  """
  @spec upload(ApiClient.t(), String.t(), upload_purpose()) :: ApiClient.api_result()
  def upload(client, file, purpose) do
    ApiClient.multipart_api_request(client, :post, @resource_path, file: file, purpose: purpose)
  end

  @doc """
  Deletes the file with the given id.
  """
  @spec delete(ApiClient.t(), String.t()) :: ApiClient.api_result()
  def delete(client, id), do: ApiClient.api_request(client, :delete, "#{@resource_path}/#{id}")

  @doc """
  Retrieve the file with the given id.
  """
  @spec retrieve(ApiClient.t(), String.t()) :: ApiClient.api_result()
  def retrieve(client, id), do: ApiClient.api_request(client, :get, "#{@resource_path}/#{id}")

  @doc """
  Retrieve the contents of the file with the given id.
  """
  @spec retrieve_content(ApiClient.t(), String.t()) :: ApiClient.api_result()
  def retrieve_content(client, id),
    do: ApiClient.api_request(client, :get, "#{@resource_path}/#{id}/content")
end
