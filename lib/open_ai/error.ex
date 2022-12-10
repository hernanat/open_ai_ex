defmodule OpenAI.Error do
  @moduledoc """
  Encapsulates errors encountered during requests to the OpenAI API.
  """

  @type t :: %__MODULE__{
          message: binary() | nil,
          code: binary() | nil,
          param: binary() | nil,
          type: binary() | nil,
          raw: term() | nil
        }

  defexception [:message, :code, :param, :type, :raw]

  @impl true
  def exception(%{"message" => msg, "code" => code, "param" => param, "type" => type} = raw) do
    %__MODULE__{
      message: msg,
      code: code,
      param: param,
      type: type,
      raw: raw
    }
  end

  def exception(raw), do: %__MODULE__{raw: raw}
end
