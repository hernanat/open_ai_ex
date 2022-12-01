import Config

if File.exists?("config/runtime.secret.exs") do
  Code.require_file("runtime.secret.exs", "config")
else
  config :open_ai,
    api_key: System.fetch_env!("OPEN_AI_API_KEY"),
    organization: System.get_env("OPEN_AI_ORGANIZATION_ID")
end
