import Config

config :open_ai,
       :application,
       children: [{Finch, name: OpenAIFinch}]

config :open_ai, :tesla,
  adapter: {Tesla.Adapter.Finch, [name: OpenAIFinch]},
  retry: [
    delay: 50,
    max_retries: 3,
    max_delay: 1000,
    should_retry: &OpenAI.ApiClient.Impl.should_retry_request/1
  ],
  json: [
    engine: Jason,
    engine_opts: []
  ]
