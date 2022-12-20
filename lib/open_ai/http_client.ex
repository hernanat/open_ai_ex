defmodule OpenAI.HttpClient do
  @type request_methods :: :get | :post | :head | :patch | :delete | :options | :put | binary()

  @spec request(
          request_methods(),
          binary(),
          list({binary(), binary()}),
          map() | nil,
          keyword()
        ) :: {:ok, map()} | {:error, Error.t() | term()}
  def request(method, url, headers, params, opts),
    do: impl().request(method, url, headers, params, opts)

  @spec multipart_request(
          request_methods(),
          binary(),
          list({binary(), binary()}),
          Multipart.t(),
          keyword()
        ) :: {:ok, map()} | {:error, Error.t() | term()}
  def multipart_request(method, url, headers, params, opts),
    do: impl().multipart_request(method, url, headers, params, opts)

  defp impl, do: Application.get_env(:open_ai, :http_client_impl, OpenAI.HttpClientImpl)
end
