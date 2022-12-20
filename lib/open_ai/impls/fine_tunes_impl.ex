defmodule OpenAI.FineTunesImpl do
  @moduledoc false

  alias OpenAI.Behaviours.FineTunesBehaviour

  @behaviour FineTunesBehaviour

  @impl FineTunesBehaviour
  def create(training_file_id, params \\ [])
      when is_binary(training_file_id) and is_list(params) do
    OpenAIClient.api_request(:post, "fine-tunes", [], [
      {:training_file, training_file_id} | params
    ])
  end

  @impl FineTunesBehaviour
  def list(), do: OpenAIClient.api_request(:get, "fine-tunes")

  @impl FineTunesBehaviour
  def retrieve(fine_tune_id) when is_binary(fine_tune_id),
    do: OpenAIClient.api_request(:get, "fine-tunes/#{fine_tune_id}")

  @impl FineTunesBehaviour
  def cancel(fine_tune_id) when is_binary(fine_tune_id),
    do: OpenAIClient.api_request(:post, "fine-tunes/#{fine_tune_id}/cancel")

  @impl FineTunesBehaviour
  def list_events(fine_tune_id) when is_binary(fine_tune_id),
    do: OpenAIClient.api_request(:get, "fine-tunes/#{fine_tune_id}/events")

  @impl FineTunesBehaviour
  def delete_model(model_id) when is_binary(model_id),
    do: OpenAIClient.api_request(:delete, "models/#{model_id}")
end
