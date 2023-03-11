defmodule OpenAI.Moderation do
  @moduledoc """
  Provides functions for interacting with OpenAI's moderation API.

  See OpenAI Moderations API documentation [here](https://beta.openai.com/docs/api-reference/moderations).
  """

  alias OpenAI.ApiClient

  @resource_path "/moderations"

  @type create_params :: {:model, String.t()}

  @doc """
  Classifies if text violates OpenAI's Content Policy.
  """
  @spec create(ApiClient.t(), String.t(), [create_params()]) :: ApiClient.api_result()
  def create(client, input, params \\ []),
    do: ApiClient.api_request(client, :post, @resource_path, [{:input, input} | params])
end
