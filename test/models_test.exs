defmodule OpenAI.ModelsTest do
  use ExUnit.Case, async: true

  alias OpenAI.Models

  doctest Models

  import Hammox

  setup :verify_on_exit!

  describe "list/0" do
    test "lists available OpenAI models" do
      expect(ModelsImplMock, :list, fn ->
        {:ok,
         [
           %{
             "created" => 1_649_358_449,
             "id" => "babbage",
             "object" => "model",
             "owned_by" => "openai",
             "parent" => nil,
             "permission" => [
               %{
                 "allow_create_engine" => false,
                 "allow_fine_tuning" => false,
                 "allow_logprobs" => true,
                 "allow_sampling" => true,
                 "allow_search_indices" => false,
                 "allow_view" => true,
                 "created" => 1_669_085_501,
                 "group" => nil,
                 "id" => "modelperm-49FUp5v084tBB49tC4z8LPH5",
                 "is_blocking" => false,
                 "object" => "model_permission",
                 "organization" => "*"
               }
             ],
             "root" => "babbage"
           },
           %{
             "created" => 1_649_357_491,
             "id" => "ada",
             "object" => "model",
             "owned_by" => "openai",
             "parent" => nil,
             "permission" => [
               %{
                 "allow_create_engine" => false,
                 "allow_fine_tuning" => false,
                 "allow_logprobs" => true,
                 "allow_sampling" => true,
                 "allow_search_indices" => false,
                 "allow_view" => true,
                 "created" => 1_669_087_301,
                 "group" => nil,
                 "id" => "modelperm-xTOEYvDZGN7UDnQ65VpzRRHz",
                 "is_blocking" => false,
                 "object" => "model_permission",
                 "organization" => "*"
               }
             ],
             "root" => "ada"
           }
         ]}
      end)

      assert {:ok, _} = Models.list()
    end
  end

  describe "get/1" do
    test "retrieves OpenAI model with given id" do
      expect(ModelsImplMock, :get, fn id ->
        assert id == "text-search-curie-doc-001"

        {:ok,
         %{
           "created" => 1_651_172_509,
           "id" => "text-search-curie-doc-001",
           "object" => "model",
           "owned_by" => "openai-dev",
           "parent" => nil,
           "permission" => [
             %{
               "allow_create_engine" => false,
               "allow_fine_tuning" => false,
               "allow_logprobs" => true,
               "allow_sampling" => true,
               "allow_search_indices" => true,
               "allow_view" => true,
               "created" => 1_669_066_353,
               "group" => nil,
               "id" => "modelperm-zjXVr8IzHdqV5Qtg5lgxS7Ci",
               "is_blocking" => false,
               "object" => "model_permission",
               "organization" => "*"
             }
           ],
           "root" => "text-search-curie-doc-001"
         }}
      end)

      assert {:ok, _} = Models.get("text-search-curie-doc-001")
    end

    test "returns an error if no model is found for given id" do
      expect(ModelsImplMock, :get, fn id ->
        assert id == "foo"

        {:error,
         %OpenAI.Error{
           code: nil,
           message: "That model does not exist",
           param: "model",
           type: "invalid_request_error"
         }}
      end)

      assert {:error, %OpenAI.Error{}} = Models.get("foo")
    end
  end
end
