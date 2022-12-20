defmodule OpenAI.Behaviours.HttpClientBehaviour do
  alias OpenAI.HttpClient
  alias OpenAI.Error

  @callback request(
              HttpClient.request_methods(),
              binary(),
              list({binary(), binary()}),
              map() | nil,
              keyword()
            ) :: {:ok, map()} | {:error, Error.t() | term()}

  @callback multipart_request(
              HttpClient.request_methods(),
              binary(),
              list({binary(), binary()}),
              Multipart.t(),
              keyword()
            ) :: {:ok, map()} | {:error, Error.t() | term()}
end
