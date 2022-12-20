defmodule OpenAI.FineTunesTest do
  use ExUnit.Case, async: true

  alias OpenAI.FineTunes

  import Hammox

  setup :verify_on_exit!

  describe "create/2" do
    test "creates a fine tune job" do
      expect(FineTunesImplMock, :create, fn training_file_id, params ->
        assert training_file_id == "test.jsonl"
        assert params == []

        {:ok,
         %{
           "created_at" => 1_671_507_582,
           "events" => [
             %{
               "created_at" => 1_671_507_583,
               "level" => "info",
               "message" => "Created fine-tune: ft-xxxnlyyyvO2FzzzPT5bbbxsK",
               "object" => "fine-tune-event"
             }
           ],
           "fine_tuned_model" => nil,
           "hyperparams" => %{
             "batch_size" => nil,
             "learning_rate_multiplier" => nil,
             "n_epochs" => 4,
             "prompt_loss_weight" => 0.01
           },
           "id" => "ft-xxxnlyyyvO2FzzzPT5bbbxsK",
           "model" => "curie",
           "object" => "fine-tune",
           "organization_id" => "org-xxxyyyGd5qzzzT6WbbbE6tS",
           "result_files" => [],
           "status" => "pending",
           "training_files" => [
             %{
               "bytes" => 144,
               "created_at" => 1_671_507_565,
               "filename" => "test.jsonl",
               "id" => "file-A3GOqNKbkggg8c6bk2zB4fOb",
               "object" => "file",
               "purpose" => "fine-tune",
               "status" => "processed",
               "status_details" => nil
             }
           ],
           "updated_at" => 1_671_507_583,
           "validation_files" => []
         }}
      end)

      assert {:ok, _} = FineTunes.create("test.jsonl")
    end
  end

  describe "list/0" do
    test "lists fine tune jobs" do
      expect(FineTunesImplMock, :list, fn ->
        {:ok,
         %{
           "data" => [
             %{
               "created_at" => 1_671_507_582,
               "fine_tuned_model" => "curie:ft-personal-2022-12-20-03-41-04",
               "hyperparams" => %{
                 "batch_size" => 1,
                 "learning_rate_multiplier" => 0.1,
                 "n_epochs" => 4,
                 "prompt_loss_weight" => 0.01
               },
               "id" => "ft-xxxnlyyyvO2FzzzPT5bbbxsK",
               "model" => "curie",
               "object" => "fine-tune",
               "organization_id" => "org-xxxyyyGd5qzzzT6WbbbE6tS",
               "result_files" => [
                 %{
                   "bytes" => 349,
                   "created_at" => 1_671_507_665,
                   "filename" => "compiled_results.csv",
                   "id" => "file-xxxjzyyy8kzzzLW1egggqXG",
                   "object" => "file",
                   "purpose" => "fine-tune-results",
                   "status" => "processed",
                   "status_details" => nil
                 }
               ],
               "status" => "succeeded",
               "training_files" => [
                 %{
                   "bytes" => 144,
                   "created_at" => 1_671_507_565,
                   "filename" => "test.jsonl",
                   "id" => "file-A3GOqNKbkggg8c6bk2zB4fOb",
                   "object" => "file",
                   "purpose" => "fine-tune",
                   "status" => "processed",
                   "status_details" => nil
                 }
               ],
               "updated_at" => 1_671_507_665,
               "validation_files" => []
             }
           ],
           "object" => "list"
         }}
      end)

      assert {:ok, _} = FineTunes.list()
    end
  end

  describe "retrieve/1" do
    test "retrieves the fine tune job info" do
      expect(FineTunesImplMock, :retrieve, fn fine_tune_id ->
        assert fine_tune_id == "ft-xxxnlyyyvO2FzzzPT5bbbxsK"

        {:ok,
         %{
           "created_at" => 1_671_507_582,
           "events" => [],
           "fine_tuned_model" => "curie:ft-personal-2022-12-20-03-41-04",
           "id" => "ft-xxxnlyyyvO2FzzzPT5bbbxsK"
           # , ... etc
         }}
      end)

      assert {:ok, _} = FineTunes.retrieve("ft-xxxnlyyyvO2FzzzPT5bbbxsK")
    end
  end

  describe "cancel/1" do
    test "cancels the fine tune job" do
      expect(FineTunesImplMock, :cancel, fn fine_tune_id ->
        assert fine_tune_id == "ft-xxxnlyyyvO2FzzzPT5bbbxsK"

        {:ok,
         %{
           "created_at" => 1_671_507_582,
           "events" => [],
           "fine_tuned_model" => "curie:ft-personal-2022-12-20-03-41-04",
           "id" => "ft-xxxnlyyyvO2FzzzPT5bbbxsK"
           # , ... etc
         }}
      end)

      assert {:ok, _} = FineTunes.cancel("ft-xxxnlyyyvO2FzzzPT5bbbxsK")
    end
  end

  describe "list_events/1" do
    test "lists the events for the fine tune job" do
      expect(FineTunesImplMock, :list_events, fn fine_tune_id ->
        assert fine_tune_id == "ft-xxxnlyyyvO2FzzzPT5bbbxsK"

        {:ok,
         %{
           "data" => [
             %{
               "created_at" => 1_671_507_582,
               "events" => [],
               "fine_tuned_model" => "curie:ft-personal-2022-12-20-03-41-04",
               "id" => "ft-xxxnlyyyvO2FzzzPT5bbbxsK"
               # , ... etc
             }
           ]
         }}
      end)

      assert {:ok, _} = FineTunes.list_events("ft-xxxnlyyyvO2FzzzPT5bbbxsK")
    end
  end

  describe "delete_model/1" do
    test "deletes the fine tuned model" do
      expect(FineTunesImplMock, :delete_model, fn model_id ->
        assert model_id == "curie:ft-personal-2022-12-20-03-41-04"

        {:ok,
         %{
           "deleted" => true,
           "id" => "curie:ft-personal-2022-12-20-03-41-04",
           "object" => "model"
         }}
      end)

      assert {:ok, _} = FineTunes.delete_model("curie:ft-personal-2022-12-20-03-41-04")
    end
  end
end
