defmodule OpenAI.Behaviours.ModerationsBehaviour do
  alias OpenAI.{Error, Moderations}

  @callback create(binary(), [Moderations.create_params()]) :: {:ok, map()} | {:error, Error.t()}
end
