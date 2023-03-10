defmodule OpenAI.Behaviours.ChatBehaviour do
  alias OpenAI.Error
  alias OpenAI.Chat

  @callback create_completion(binary(), [Chat.message()], [Chat.create_completion_params()]) ::
              {:ok, map()} | {:error, Error.t()}
end
