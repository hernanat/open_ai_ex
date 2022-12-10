defmodule OpenAIClientTest do
  use ExUnit.Case, async: true

  describe "api_request/5" do
    test "returns an error when `stream: true` is passed in `params`" do
      assert {:error,
              %OpenAI.Error{
                message:
                  "Streaming server-sent events is not currently supported by this API client."
              }} =
               OpenAIClient.api_request(
                 :post,
                 :completions,
                 [],
                 %{model: "text-davinci-001", prompt: "hello there", stream: true},
                 []
               )
    end
  end

  describe "decode/1" do
    test "decodes JSON objects" do
      assert {:ok, %{"foo" => "bar"}} = OpenAIClient.decode("{\"foo\":\"bar\"}")
    end

    test "decodes arrays of JSON objects" do
      assert {:ok, [%{"foo" => "bar"}, %{"biz" => "baz"}]} =
               OpenAIClient.decode("{\"data\":[{\"foo\":\"bar\"},{\"biz\":\"baz\"}]}")
    end

    test "decodes errors into our error struct" do
      json =
        "{\"error\":{\"message\":\"That model does not exist\"," <>
          "\"type\":\"invalid_request_error\",\"param\":\"model\",\"code\": null}}"

      assert {:error,
              %OpenAI.Error{
                message: "That model does not exist",
                code: nil,
                param: "model",
                type: "invalid_request_error",
                raw: %{
                  "code" => nil,
                  "message" => "That model does not exist",
                  "param" => "model",
                  "type" => "invalid_request_error"
                }
              }} = OpenAIClient.decode(json)
    end
  end
end
