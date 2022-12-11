defmodule OpenAI.ImagesTest do
  use ExUnit.Case, async: true

  alias OpenAI.Images

  import Hammox

  setup :verify_on_exit!

  describe "generate/2" do
    test "generates an image from the prompt" do
      expect(ImagesImplMock, :generate, fn prompt, params ->
        assert prompt == "a cute cat"
        assert params == []

        {:ok,
         [
           %{"url" => "https://theimage.com/url"}
         ]}
      end)

      assert {:ok, _} = Images.generate("a cute cat", [])
    end
  end
end
