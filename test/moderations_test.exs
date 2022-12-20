defmodule OpenAI.ModerationsTest do
  use ExUnit.Case, async: true

  alias OpenAI.Moderations

  import Hammox

  setup :verify_on_exit!

  describe "create/2" do
    test "creates a moderation" do
      expect(ModerationsImplMock, :create, fn input, params ->
        assert input == "you're not nice"
        assert params == []

        {:ok,
         %{
           "id" => "modr-6POGaLBtW7EZiZWcin98loziu5QgJ",
           "model" => "text-moderation-004",
           "results" => [
             %{
               "categories" => %{
                 "hate" => false,
                 "hate/threatening" => false,
                 "self-harm" => false,
                 "sexual" => false,
                 "sexual/minors" => false,
                 "violence" => false,
                 "violence/graphic" => false
               },
               "category_scores" => %{
                 "hate" => 1.6101970459203585e-6,
                 "hate/threatening" => 2.4938461018475522e-11,
                 "self-harm" => 2.5834323569284834e-9,
                 "sexual" => 2.014702658925671e-6,
                 "sexual/minors" => 1.1193016291599633e-8,
                 "violence" => 8.914289750805438e-9,
                 "violence/graphic" => 4.686926541319636e-11
               },
               "flagged" => false
             }
           ]
         }}
      end)

      assert {:ok, _} = Moderations.create("you're not nice")
    end
  end
end
