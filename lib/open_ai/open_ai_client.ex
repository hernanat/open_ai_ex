defmodule OpenAIClient do
  @moduledoc false

  alias OpenAI.Error

  @base_url "https://api.openai.com"
  @api_version "v1"

  def api_request(method, resource, headers \\ [], body \\ nil, opts \\ []) do
    request_url = "#{@base_url}/#{@api_version}/#{resource}"
    api_key = Application.fetch_env!(:open_ai, :api_key)
    organization = Application.get_env(:open_ai, :organization, nil)

    headers = [{"Authorization", "Bearer #{api_key}"} | headers]

    headers =
      if organization != nil, do: [{"OpenAI-Organization", organization} | headers], else: headers

    case request(method, request_url, headers, body, opts) do
      {:ok, %Finch.Response{body: body}} -> decode(body)
      {:error, error} -> {:error, error}
    end
  end

  def request(:get, url, headers, body, opts),
    do: Finch.build(:get, url, headers, body, opts) |> Finch.request(OpenAI.Finch)

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
