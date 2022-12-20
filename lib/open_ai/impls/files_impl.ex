defmodule OpenAI.FilesImpl do
  @moduledoc false

  alias OpenAI.Behaviours.FilesBehaviour

  @behaviour FilesBehaviour

  @impl FilesBehaviour
  def list(), do: OpenAIClient.api_request(:get, :files)

  @impl FilesBehaviour
  def upload(file, purpose) when is_binary(file) and is_binary(purpose),
    do: OpenAIClient.multipart_api_request(:post, :files, [], file: file, purpose: purpose)

  @impl FilesBehaviour
  def delete(id) when is_binary(id), do: OpenAIClient.api_request(:delete, "files/#{id}")

  @impl FilesBehaviour
  def retrieve(id) when is_binary(id), do: OpenAIClient.api_request(:get, "files/#{id}")

  @impl FilesBehaviour
  def retrieve_content(id) when is_binary(id),
    do: OpenAIClient.api_request(:get, "files/#{id}/content")
end
