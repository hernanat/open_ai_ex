alias OpenAI.Behaviours.{CompletionsBehaviour, EditsBehaviour, ImagesBehaviour, ModelsBehaviour, EmbeddingsBehaviour}

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

ExUnit.start()
