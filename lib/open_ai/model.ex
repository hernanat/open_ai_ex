defmodule OpenAI.Model do
  @moduledoc """
  Provides functions for listing and retrieving information about OpenAI models.

  See OpenAI Models API documentation [here](https://beta.openai.com/docs/api-reference/models).
  """

  alias OpenAI.ApiClient

  @resource_path "/models"

  @doc """
  Lists all available OpenAI models.
  """
  @spec list(ApiClient.t()) :: ApiClient.api_result()
  def list(client), do: client |> ApiClient.api_request(:get, @resource_path)

  @doc """
  Retrieves the model with the given ID.
  """
  @spec get(ApiClient.t(), String.t()) :: ApiClient.api_result()
  def get(client, id), do: ApiClient.api_request(client, :get, "#{@resource_path}/#{id}")
end
