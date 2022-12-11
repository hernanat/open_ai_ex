defmodule OpenAI.Behaviours.ImagesBehaviour do
  alias OpenAI.Error
  alias OpenAI.Images

  @callback generate(binary(), [Images.generate_params()]) :: {:ok, [map()]} | {:error, Error.t()}
end
