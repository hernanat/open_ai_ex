defmodule OpenAIClient do
  @moduledoc false

  alias OpenAI.Error

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

  def api_request(_, _, _, %{stream: true}, _),
    do:
      {:error,
       %Error{
         message: "Streaming server-sent events is not currently supported by this API client."
       }}

  def api_request(method, resource, headers, params, opts) do
    headers = combine_with_auth_headers([{"Content-Type", "application/json"} | headers])

    case request(method, request_url(resource), headers, params, opts) do
      {:ok, %Finch.Response{body: body}} -> decode(body)
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
    multipart =
      Map.drop(params, [:image, :mask])
      |> build_multipart_request_body()
      |> Multipart.add_part(Multipart.Part.file_field(image, :image))
      |> Multipart.add_part(Multipart.Part.file_field(mask, :mask))

    do_multi_part_request(:post, resource, headers, multipart, opts)
  end

  def multipart_api_request(:post, resource, headers, %{image: image} = params, opts) do
    multipart =
      Map.drop(params, [:image])
      |> build_multipart_request_body()
      |> Multipart.add_part(Multipart.Part.file_field(image, :image))

    do_multi_part_request(:post, resource, headers, multipart, opts)
  end

  def multipart_api_request(:post, resource, headers, %{file: file} = params, opts) do
    multipart =
      Map.drop(params, [:file])
      |> build_multipart_request_body()
      |> Multipart.add_part(Multipart.Part.file_field(file, :file))

    do_multi_part_request(:post, resource, headers, multipart, opts)
  end

  defp build_multipart_request_body(params, multipart \\ Multipart.new()) do
    for {param, value} <- params,
        reduce: multipart,
        do:
          (result ->
             Multipart.add_part(result, Multipart.Part.text_field(to_string(value), param)))
  end

  def request(method, url, headers, nil, opts),
    do: Finch.build(method, url, headers, nil, opts) |> Finch.request(OpenAI.Finch)

  def request(_, url, headers, {:stream, _} = params, opts) do
    request = Finch.build("POST", url, headers, params, opts)

    request |> Finch.request(OpenAI.Finch)
  end

  def request(method, url, headers, params, opts),
    do:
      Finch.build(method, url, headers, Jason.encode!(params), opts)
      |> Finch.request(OpenAI.Finch)

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

  defp do_multi_part_request(:post, resource, headers, multipart, opts) do
    body_stream = Multipart.body_stream(multipart)
    content_type = Multipart.content_type(multipart, "multipart/form-data")
    content_length = Multipart.content_length(multipart)

    headers =
      combine_with_auth_headers([
        {"Content-Type", content_type},
        {"Content-Length", to_string(content_length)} | headers
      ])

    case request(:post, request_url(resource), headers, {:stream, body_stream}, opts) do
      {:ok, %Finch.Response{body: body}} -> decode(body)
      {:error, error} -> {:error, error}
    end
  end

  defp request_url(resource), do: "#{@base_url}/#{@api_version}/#{resource}"
end
