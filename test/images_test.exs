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

        {:ok, %{"data" => [%{"url" => "https://theimage.com/url"}]}}
      end)

      assert {:ok, _} = Images.generate("a cute cat", [])
    end
  end

  describe "edit/3" do
    test "edits the given image according to the prompt" do
      expect(ImagesImplMock, :edit, fn prompt, image, params ->
        assert prompt == "add a cat face"
        assert image == "volley.png"
        assert params == []

        {:ok, %{"data" => [%{"url" => "https://theimage.com/url"}]}}
      end)

      assert {:ok, _} = Images.edit("add a cat face", "volley.png", [])
    end
  end

  describe "variation/2" do
    test "creates a variation of the given image" do
      expect(ImagesImplMock, :variation, fn image, params ->
        assert image == "volley.png"
        assert params == []

        {:ok, %{"data" => [%{"url" => "https://theimage.com/url"}]}}
      end)

      assert {:ok, _} = Images.variation("volley.png", [])
    end
  end
end
