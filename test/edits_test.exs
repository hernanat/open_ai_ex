defmodule OpenAI.EditsTest do
  use ExUnit.Case, async: true

  alias OpenAI.Edits

  import Hammox

  setup :verify_on_exit!

  describe "create/4" do
    test "creates a new OpenAI completion" do
      expect(EditsImplMock, :create, fn model, input, instruction, params ->
        assert model == "text-davinci-edit-001"
        assert input == "henlo, how r u?"
        assert instruction == "correct the spelling mistakes"
        assert params == [{:temperature, 0.5}]

        {:ok,
         %{
           "choices" => [%{"index" => 0, "text" => "Hello, how are you?\n"}],
           "created" => 1_670_714_327,
           "object" => "edit",
           "usage" => %{
             "completion_tokens" => 24,
             "prompt_tokens" => 23,
             "total_tokens" => 47
           }
         }}
      end)

      assert {:ok, _} =
               Edits.create(
                 "text-davinci-edit-001",
                 "henlo, how r u?",
                 "correct the spelling mistakes",
                 temperature: 0.5
               )
    end
  end
end
