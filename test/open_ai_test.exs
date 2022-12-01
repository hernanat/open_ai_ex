defmodule OpenAITest do
  use ExUnit.Case
  doctest OpenAI

  test "greets the world" do
    assert OpenAI.hello() == :world
  end
end
