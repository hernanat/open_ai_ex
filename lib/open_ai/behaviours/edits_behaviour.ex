defmodule OpenAI.Behaviours.EditsBehaviour do
  alias OpenAI.Error
  alias OpenAI.Edits

  @callback create(binary(), binary(), binary(), [Edits.create_params()]) ::
              {:ok, map()} | {:error, Error.t()}
end
