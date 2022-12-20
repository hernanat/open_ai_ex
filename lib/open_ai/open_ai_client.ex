defmodule OpenAIClient do
  @moduledoc false

  alias OpenAI.{Error, HttpClient}

  @base_url "https://api.openai.com"
  @api_version "v1"

  def api_request(method, resource, headers \\ [], params \\ nil, opts \\ [])

  def api_request(method, resource, headers, params, opts) when is_list(params) do
    if Keyword.keyword?(params) do
      api_request(method, resource, headers, Enum.into(params, %{}), opts)
    else
      {:error, %Error{message: "Expected a keyword list or map for API request params."}}
    end
  end

  def api_request(method, resource, headers, params, opts) do
    headers = combine_with_auth_headers([{"Content-Type", "application/json"} | headers])

    case HttpClient.request(method, request_url(resource), headers, params, opts) do
      {:ok, body} -> decode(body)
      {:error, error} -> {:error, error}
    end
  end

  def multipart_api_request(method, resource, headers \\ [], params \\ nil, opts \\ [])

  def multipart_api_request(method, resource, headers, params, opts) when is_list(params) do
    if Keyword.keyword?(params) do
      multipart_api_request(method, resource, headers, Enum.into(params, %{}), opts)
    else
      {:error, %Error{message: "Expected a keyword list or map for API request params."}}
    end
  end

  def multipart_api_request(:post, resource, headers, %{image: image, mask: mask} = params, opts) do
    headers = combine_with_auth_headers(headers)

    multipart =
      Map.drop(params, [:image, :mask])
      |> build_multipart_request_body()
      |> Multipart.add_part(Multipart.Part.file_field(image, :image))
      |> Multipart.add_part(Multipart.Part.file_field(mask, :mask))

    case HttpClient.multipart_request(:post, request_url(resource), headers, multipart, opts) do
      {:ok, body} -> decode(body)
      {:error, error} -> {:error, error}
    end
  end

  def multipart_api_request(:post, resource, headers, %{image: image} = params, opts) do
    headers = combine_with_auth_headers(headers)

    multipart =
      Map.drop(params, [:image])
      |> build_multipart_request_body()
      |> Multipart.add_part(Multipart.Part.file_field(image, :image))

    case HttpClient.multipart_request(:post, request_url(resource), headers, multipart, opts) do
      {:ok, body} -> decode(body)
      {:error, error} -> {:error, error}
    end
  end

  def multipart_api_request(:post, resource, headers, %{file: file} = params, opts) do
    headers = combine_with_auth_headers(headers)

    multipart =
      Map.drop(params, [:file])
      |> build_multipart_request_body()
      |> Multipart.add_part(Multipart.Part.file_field(file, :file))

    case HttpClient.multipart_request(:post, request_url(resource), headers, multipart, opts) do
      {:ok, body} -> decode(body)
      {:error, error} -> {:error, error}
    end
  end

  defp build_multipart_request_body(params, multipart \\ Multipart.new()) do
    for {param, value} <- params, reduce: multipart do
      result ->
        Multipart.add_part(result, Multipart.Part.text_field(to_string(value), param))
    end
  end

  def decode(body) do
    case Jason.decode!(body) do
      %{"error" => error} ->
        {:error, Error.exception(error)}

      %{"data" => _data} = result ->
        {:ok, result}

      %{} = object ->
        {:ok, object}
    end
  end

  defp combine_with_auth_headers(headers) do
    api_key = Application.fetch_env!(:open_ai, :api_key)
    organization = Application.get_env(:open_ai, :organization, nil)

    headers = [{"Authorization", "Bearer #{api_key}"} | headers]

    if organization != nil, do: [{"OpenAI-Organization", organization} | headers], else: headers
  end

  defp request_url(resource), do: "#{@base_url}/#{@api_version}/#{resource}"
end
