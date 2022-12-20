defmodule OpenAIClientTest do
  use ExUnit.Case, async: true

  describe "decode/1" do
    test "decodes JSON objects" do
      assert {:ok, %{"foo" => "bar"}} = OpenAIClient.decode("{\"foo\":\"bar\"}")
    end

    test "decodes arrays of JSON objects" do
      assert {:ok, %{"data" => [%{"foo" => "bar"}, %{"biz" => "baz"}]}} =
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
