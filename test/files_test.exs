defmodule OpenAI.FilesTest do
  use ExUnit.Case, async: true

  alias OpenAI.Files

  import Hammox

  setup :verify_on_exit!

  describe "list/0" do
    test "lists user's files" do
      expect(FilesImplMock, :list, fn ->
        {:ok,
         %{
           "data" => [
             %{
               "bytes" => 144,
               "created_at" => 1_671_504_775,
               "filename" => "test.jsonl",
               "id" => "file-A3GOqNKbkggg8c6bk2zB4fOb",
               "object" => "file",
               "purpose" => "fine-tune",
               "status" => "processed",
               "status_details" => nil
             }
           ],
           "object" => "list"
         }}
      end)

      assert {:ok, _} = Files.list()
    end
  end

  describe "upload/2" do
    test "uploads the file" do
      expect(FilesImplMock, :upload, fn file, purpose ->
        assert file == "test.jsonl"
        assert purpose == "fine-tune"

        {:ok,
         %{
           "bytes" => 144,
           "created_at" => 1_671_504_775,
           "filename" => "test.jsonl",
           "id" => "file-A3GOqNKbkggg8c6bk2zB4fOb",
           "object" => "file",
           "purpose" => "fine-tune",
           "status" => "processed",
           "status_details" => nil
         }}
      end)

      assert {:ok, _} = Files.upload("test.jsonl", "fine-tune")
    end
  end

  describe "delete/1" do
    test "deletes the file" do
      expect(FilesImplMock, :delete, fn id ->
        assert id == "file-A3GOqNKbkggg8c6bk2zB4fOb"

        {:ok,
         %{
           "deleted" => true,
           "id" => "file-A3GOqNKbkggg8c6bk2zB4fOb",
           "object" => "file"
         }}
      end)

      assert {:ok, _} = Files.delete("file-A3GOqNKbkggg8c6bk2zB4fOb")
    end
  end

  describe "retrieve/1" do
    test "retrieves the file" do
      expect(FilesImplMock, :retrieve, fn id ->
        assert id == "file-A3GOqNKbkggg8c6bk2zB4fOb"

        {:ok,
         %{
           "bytes" => 144,
           "created_at" => 1_671_504_775,
           "filename" => "test.jsonl",
           "id" => "file-A3GOqNKbkggg8c6bk2zB4fOb",
           "object" => "file",
           "purpose" => "fine-tune",
           "status" => "processed",
           "status_details" => nil
         }}
      end)

      assert {:ok, _} = Files.retrieve("file-A3GOqNKbkggg8c6bk2zB4fOb")
    end
  end

  describe "retrieve_content/1" do
    test "retrieves the contents of the file" do
      expect(FilesImplMock, :retrieve_content, fn id ->
        assert id == "file-A3GOqNKbkggg8c6bk2zB4fOb"

        {:ok,
         %{
           "completion" => "billing@example.com,engineering@example.com",
           "prompt" => "We can't access our billing information and are seeing a vague error"
         }}
      end)

      assert {:ok, _} = Files.retrieve_content("file-A3GOqNKbkggg8c6bk2zB4fOb")
    end
  end
end
