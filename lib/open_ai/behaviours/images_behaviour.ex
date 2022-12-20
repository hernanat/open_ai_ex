defmodule OpenAI.Behaviours.ImagesBehaviour do
  alias OpenAI.Error
  alias OpenAI.Images

  @callback generate(binary(), [Images.generate_params()]) :: {:ok, [map()]} | {:error, Error.t()}
  @callback edit(binary(), binary(), [Images.edit_params()]) ::
              {:ok, [map()]} | {:error, Error.t()}
end
