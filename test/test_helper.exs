alias OpenAI.Behaviours.{
  CompletionsBehaviour,
  EditsBehaviour,
  ImagesBehaviour,
  ModelsBehaviour,
  EmbeddingsBehaviour,
  FilesBehaviour,
  FineTunesBehaviour
}

Hammox.defmock(ModelsImplMock, for: ModelsBehaviour)
Application.put_env(:open_ai, :models_impl, ModelsImplMock)

Hammox.defmock(CompletionsImplMock, for: CompletionsBehaviour)
Application.put_env(:open_ai, :completions_impl, CompletionsImplMock)

Hammox.defmock(EditsImplMock, for: EditsBehaviour)
Application.put_env(:open_ai, :edits_impl, EditsImplMock)

Hammox.defmock(ImagesImplMock, for: ImagesBehaviour)
Application.put_env(:open_ai, :images_impl, ImagesImplMock)

Hammox.defmock(EmbeddingsImplMock, for: EmbeddingsBehaviour)
Application.put_env(:open_ai, :embeddings_impl, EmbeddingsImplMock)

Hammox.defmock(FilesImplMock, for: FilesBehaviour)
Application.put_env(:open_ai, :files_impl, FilesImplMock)

Hammox.defmock(FineTunesImplMock, for: FineTunesBehaviour)
Application.put_env(:open_ai, :fine_tunes_impl, FineTunesImplMock)

ExUnit.start()
