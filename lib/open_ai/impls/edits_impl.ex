defmodule OpenAI.EditsImpl do
  @moduledoc false

  alias OpenAI.Behaviours.EditsBehaviour

  @behaviour EditsBehaviour

  @impl EditsBehaviour
  def create(model, input, instruction, params)
      when is_binary(input) and is_binary(instruction) and is_list(params) do
    OpenAIClient.api_request(:post, :edits, [], [
      {:model, model},
      {:input, input},
      {:instruction, instruction} | params
    ])
  end
end
