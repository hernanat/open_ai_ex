defmodule OpenAI.CompletionsTest do
  use ExUnit.Case, async: true

  alias OpenAI.Completions

  import Hammox

  setup :verify_on_exit!

  describe "create/3" do
    test "creates a new OpenAI completion" do
      expect(CompletionsImplMock, :create, fn model, prompt, params ->
        assert model == "text-davinci-001"
        assert prompt == "hello, how are you?"
        assert params == []

        {:ok,
         %{
           "choices" => [
             %{
               "finish_reason" => "stop",
               "index" => 0,
               "logprobs" => nil,
               "text" => "\n\nI'm doing well, thank you. How about you?"
             }
           ],
           "created" => 1_670_710_238,
           "id" => "cmpl-xxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
           "model" => "text-ada-001",
           "object" => "text_completion",
           "usage" => %{
             "completion_tokens" => 14,
             "prompt_tokens" => 6,
             "total_tokens" => 20
           }
         }}
      end)

      assert {:ok, _} = Completions.create("text-davinci-001", "hello, how are you?", [])
    end
  end
end
