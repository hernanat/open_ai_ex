defmodule OpenAIClient do
  @moduledoc false

  alias OpenAI.Error

  @base_url "https://api.openai.com"
  @api_version "v1"

  def api_request(method, resource, headers \\ [], params \\ nil, opts \\ [])

  def api_request(_, _, _, %{stream: true}, _),
    do:
      {:error,
       %Error{
         message: "Streaming server-sent events is not currently supported by this API client."
       }}

  def api_request(method, resource, headers, params, opts) do
    request_url = "#{@base_url}/#{@api_version}/#{resource}"
    api_key = Application.fetch_env!(:open_ai, :api_key)
    organization = Application.get_env(:open_ai, :organization, nil)

    headers = [
      {"Authorization", "Bearer #{api_key}"},
      {"Content-Type", "application/json"} | headers
    ]

    headers =
      if organization != nil, do: [{"OpenAI-Organization", organization} | headers], else: headers

    case request(method, request_url, headers, params, opts) do
      {:ok, %Finch.Response{body: body}} -> decode(body)
      {:error, error} -> {:error, error}
    end
  end

  def request(method, url, headers, nil, opts),
    do: Finch.build(method, url, headers, nil, opts) |> Finch.request(OpenAI.Finch)

  def request(method, url, headers, params, opts),
    do:
      Finch.build(method, url, headers, Jason.encode!(params), opts)
      |> Finch.request(OpenAI.Finch)

  def decode(body) do
    case Jason.decode!(body) do
      %{"error" => error} ->
        {:error, Error.exception(error)}

      %{"data" => data} ->
        {:ok, data}

      %{} = object ->
        {:ok, object}
    end
  end
end
