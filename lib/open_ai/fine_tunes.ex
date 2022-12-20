defmodule OpenAI.FineTunes do
  @moduledoc """
  Provides the ability to interact with the OpenAI fine tuness API.

  See the OpenAI fine tuness API documentation [here](https://beta.openai.com/docs/api-reference/fine-tunes).
  """
  alias OpenAI.Error

  @type create_params ::
          {:validation_file, binary()}
          | {:model, binary()}
          | {:n_epochs, non_neg_integer()}
          | {:batch_size, non_neg_integer()}
          | {:learning_rate_multiplier, number()}
          | {:prompt_loss_weight, number()}
          | {:compute_classification_metrics, boolean()}
          | {:classification_n_classes, non_neg_integer()}
          | {:classification_positive_class, binary()}
          | {:classification_betas, [number()]}
          | {:suffix, binary()}

  @doc """
  Creates a job that fine-tunes a specified model from a given dataset.
  """
  @spec create(binary(), [create_params()]) :: {:ok, map()} | {:error, Error.t()}
  def create(training_file_id, params \\ []) when is_binary(training_file_id) and is_list(params),
    do: impl().create(training_file_id, params)

  @doc """
  List your organization's fine-tuning jobs
  """
  @spec list() :: {:ok, map()} | {:error, Error.t()}
  def list(), do: impl().list()

  @doc """
  Gets info about the fine-tune job with the given id.
  """
  @spec retrieve(binary()) :: {:ok, map()} | {:error, Error.t()}
  def retrieve(fine_tune_id) when is_binary(fine_tune_id), do: impl().retrieve(fine_tune_id)

  @doc """
  Immediately cancel a fine-tune job.
  """
  @spec cancel(binary()) :: {:ok, map()} | {:error, Error.t()}
  def cancel(fine_tune_id) when is_binary(fine_tune_id), do: impl().cancel(fine_tune_id)

  @doc """
  Get fine-grained status updates for a fine-tune job.
  """
  @spec list_events(binary()) :: {:ok, map()} | {:error, Error.t()}
  def list_events(fine_tune_id) when is_binary(fine_tune_id), do: impl().list_events(fine_tune_id)

  @doc """
  Delete a fine-tuned model. You must have the Owner role in your organization.
  """
  @spec delete_model(binary()) :: {:ok, map()} | {:error, Error.t()}
  def delete_model(model_id) when is_binary(model_id), do: impl().delete_model(model_id)

  defp impl, do: Application.get_env(:open_ai, :fine_tunes_impl, OpenAI.FineTunesImpl)
end
