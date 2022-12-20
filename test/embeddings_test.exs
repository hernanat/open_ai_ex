defmodule OpenAI.EmbeddingsTest do
  use ExUnit.Case, async: true

  alias OpenAI.Embeddings

  import Hammox

  setup :verify_on_exit!

  describe "create/3" do
    expect(EmbeddingsImplMock, :create, fn model, input, params ->
      assert model == "text-embedding-ada-002"
      assert input == "the food was delicious"
      assert params == []

      {:ok, %{"data" => %{"embedding" => [0.019845005, -0.0033339353, -0.0077971583]}}}
    end)

    assert {:ok, _} = Embeddings.create("text-embedding-ada-002", "the food was delicious")
  end
end
