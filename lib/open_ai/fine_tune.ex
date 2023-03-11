defmodule OpenAI.FineTune do
  @moduledoc """
  Provides the ability to interact with the OpenAI fine tuness API.

  See the OpenAI fine tuness API documentation [here](https://beta.openai.com/docs/api-reference/fine-tunes).
  """

  alias OpenAI.ApiClient

  @resource_path "/fine-tunes"

  @type create_params ::
          {:validation_file, String.t()}
          | {:model, String.t()}
          | {:n_epochs, non_neg_integer()}
          | {:batch_size, non_neg_integer()}
          | {:learning_rate_multiplier, number()}
          | {:prompt_loss_weight, number()}
          | {:compute_classification_metrics, boolean()}
          | {:classification_n_classes, non_neg_integer()}
          | {:classification_positive_class, String.t()}
          | {:classification_betas, [number()]}
          | {:suffix, String.t()}

  @doc """
  Creates a job that fine-tunes a specified model from a given dataset.
  """
  @spec create(ApiClient.t(), String.t(), [create_params()]) :: ApiClient.api_result()
  def create(client, training_file_id, params \\ []) do
    ApiClient.api_request(client, :post, @resource_path, [
      {:training_file, training_file_id} | params
    ])
  end

  @doc """
  List your organization's fine-tuning jobs
  """
  @spec list(ApiClient.t()) :: ApiClient.api_result()
  def list(client), do: ApiClient.api_request(client, :get, @resource_path)

  @doc """
  Gets info about the fine-tune job with the given id.
  """
  @spec retrieve(ApiClient.t(), String.t()) :: ApiClient.api_result()
  def retrieve(client, fine_tune_id),
    do: ApiClient.api_request(client, :get, "#{@resource_path}/#{fine_tune_id}")

  @doc """
  Immediately cancel a fine-tune job.
  """
  @spec cancel(ApiClient.t(), String.t()) :: ApiClient.api_result()
  def cancel(client, fine_tune_id),
    do: ApiClient.api_request(client, :post, "#{@resource_path}/#{fine_tune_id}/cancel")

  @doc """
  Get fine-grained status updates for a fine-tune job.
  """
  @spec list_events(ApiClient.t(), String.t()) :: ApiClient.api_result()
  def list_events(client, fine_tune_id),
    do: ApiClient.api_request(client, :get, "#{@resource_path}/#{fine_tune_id}/events")

  @doc """
  Delete a fine-tuned model. You must have the Owner role in your organization.
  """
  @spec delete_model(ApiClient.t(), String.t()) :: ApiClient.api_result()
  def delete_model(client, model_id),
    do: ApiClient.api_request(client, :delete, "/models/#{model_id}")
end
