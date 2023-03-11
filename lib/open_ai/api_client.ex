defmodule OpenAI.ApiClient do
  @client_impl Application.compile_env(:open_ai, [:impls, :api_client], OpenAI.ApiClient.Impl)

  @typedoc """
  API Client type. `http_config` contains configuration options for requests. By
  default it will be a `t:Tesla.Client.t/0` since we use `Tesla`, but your own
  API client impl can use whatever it wants.
  """
  @type t :: %__MODULE__{
          api_key: String.t(),
          organization: String.t(),
          http_config: Tesla.Client.t() | term()
        }
  defstruct [:api_key, :organization, :http_config]

  @type request_method() :: :head | :get | :delete | :trace | :options | :post | :put | :patch

  @typedoc """
  Result type returned by `api_request/4` and `multipart_api_request/4`.
  """
  @type api_result() :: {:ok | :error, map()}

  @doc """
  Returns a new `t:t/0` for using to make requests.

  ## Args

    - `api_key` - Your OpenAI API key. Looks in application environment if not given.
    - `organization` - Your OpenAI organization (optional). Looks in application environment if not given.
    - `retry` - Retry options (defaults to `false`).

  ## Retry options

    Retry functionality uses the `Tesla.Middleware.Retry` middleware in the default impl.

  ### Defaults

  You can enable retries with some default settings:

      iex> OpenAI.ApiClient.new(retry: true)

  If you did configure retries in your config file, our default retry settings will be used:

  - `delay` - `50`
  - `max_retries` - `3`
  - `max_delay` - `1000`


  Only 429s are retried by default (rate limit errors).

  ### Custom retry settings

  You can supply your own retry settings by providing a keyword list for the `retry` option:

      iex> OpenAI.ApiClient.new(retry: [delay: 100, max_retries: 10, max_delay: 5000])
  """
  @spec new(api_key: String.t(), organization: String.t()) :: t()
  defdelegate new(opts \\ []), to: @client_impl

  @doc """
  Makes an API request.
  """
  @spec api_request(t(), request_method(), String.t(), keyword()) :: api_result()
  defdelegate api_request(client, method, resource, params \\ []), to: @client_impl

  @doc """
  Makes a multipart API request.
  """
  @spec multipart_api_request(t(), request_method(), String.t(), keyword()) :: api_result()
  defdelegate multipart_api_request(client, method, resource, params \\ []), to: @client_impl

  defmodule ApiClientBehaviour do
    @moduledoc """
    Defines minimum set of functions that api clients must implement.
    """

    alias OpenAI.ApiClient

    @callback new(api_key: String.t(), organization: String.t()) :: ApiClient.t()
    @callback api_request(ApiClient.t(), ApiClient.request_method(), String.t(), keyword()) ::
                ApiClient.api_result()
    @callback multipart_api_request(
                ApiClient.t(),
                ApiClient.request_method(),
                String.t(),
                keyword()
              ) :: ApiClient.api_result()
  end

  defmodule Impl do
    @moduledoc false
    @api_url "https://api.openai.com"
    @api_version "v1"

    alias OpenAI.ApiClient
    alias OpenAI.ApiClient.ApiClientBehaviour
    alias Tesla.Multipart

    use Tesla, docs: false

    @behaviour ApiClientBehaviour

    @http_adapter Application.compile_env!(:open_ai, [:tesla, :adapter])

    @impl ApiClientBehaviour
    def new(opts \\ []) do
      api_key = Keyword.get(opts, :api_key, api_key_from_env())
      organization = Keyword.get(opts, :organization, organization_from_env())
      http_config = build_middleware(api_key, organization, opts) |> Tesla.client(@http_adapter)
      %ApiClient{api_key: api_key, organization: organization, http_config: http_config}
    end

    @impl ApiClientBehaviour
    def api_request(client, method, resource, params \\ [])

    def api_request(%ApiClient{} = client, :get, resource, _) do
      client.http_config
      |> get(resource)
      |> handle_response()
    end

    def api_request(%ApiClient{} = client, method, resource, params) do
      client.http_config
      |> request(method: method, url: resource, body: Enum.into(params, %{}))
      |> handle_response()
    end

    @impl ApiClientBehaviour
    def multipart_api_request(%ApiClient{} = client, method, resource, params \\ []) do
      client.http_config
      |> request(
        method: method,
        url: resource,
        body: params |> Enum.into(%{}) |> multipart_request_body()
      )
      |> handle_response()
    end

    defp build_middleware(api_key, nil, opts) do
      []
      |> add_http_middleware(api_key)
      |> add_json_middleware(opts)
      |> maybe_add_retry_middleware(opts)
    end

    defp build_middleware(api_key, organization, opts) do
      [{Tesla.Middleware.Headers, [{"OpenAI-Organization", organization}]}]
      |> add_http_middleware(api_key)
      |> add_json_middleware(opts)
      |> maybe_add_retry_middleware(opts)
    end

    defp add_http_middleware(middleware, api_key) do
      [
        {Tesla.Middleware.BaseUrl, "#{@api_url}/#{@api_version}"},
        {Tesla.Middleware.BearerAuth, token: api_key}
        | middleware
      ]
    end

    @json_middleware_defaults Application.compile_env!(:open_ai, [:tesla, :json])

    def add_json_middleware(middleware, opts) do
      json_settings = Keyword.get(opts, :json, [])

      if json_settings == [] do
        [{Tesla.Middleware.JSON, @json_middleware_defaults} | middleware]
      else
        [
          {Tesla.Middleware.JSON, Keyword.merge(@json_middleware_defaults, json_settings)}
          | middleware
        ]
      end
    end

    @retry_middleware_defaults Application.compile_env!(:open_ai, [:tesla, :retry])

    defp maybe_add_retry_middleware(middleware, opts) do
      retry_settings = Keyword.get(opts, :retry, false)

      cond do
        retry_settings == false ->
          middleware

        retry_settings == true ->
          [{Tesla.Middleware.Retry, @retry_middleware_defaults} | middleware]

        Keyword.keyword?(retry_settings) ->
          [
            {Tesla.Middleware.Retry, Keyword.merge(@retry_middleware_defaults, retry_settings)}
            | middleware
          ]
      end
    end

    def should_retry_request(response) do
      case response do
        {:ok, %{status: 429}} -> true
        _ -> false
      end
    end

    defp handle_response({:ok, %Tesla.Env{body: %{"error" => _} = body}}), do: {:error, body}
    defp handle_response({:ok, %Tesla.Env{body: body}}), do: {:ok, body}
    defp handle_response({:error, error}), do: {:error, error}

    defp multipart_request_body(%{file: file} = params) do
      Multipart.new()
      |> Multipart.add_file(file, name: "file", detect_content_type: true)
      |> add_params_to_multipart_request(Map.drop(params, [:file]))
    end

    defp multipart_request_body(%{image: image} = params) do
      Multipart.new()
      |> Multipart.add_file(image, name: "image", detect_content_type: true)
      |> add_params_to_multipart_request(Map.drop(params, [:image]))
    end

    defp multipart_request_body(%{mask: mask} = params) do
      Multipart.new()
      |> Multipart.add_file(mask, name: "mask", detect_content_type: true)
      |> add_params_to_multipart_request(Map.drop(params, [:mask]))
    end

    defp add_params_to_multipart_request(multipart, params) do
      for {param, value} <- params, reduce: multipart do
        mp -> Multipart.add_field(mp, to_string(param), value)
      end
    end

    defp api_key_from_env(), do: Application.fetch_env!(:open_ai, :api_key)
    defp organization_from_env(), do: Application.get_env(:open_ai, :organization)
  end
end
