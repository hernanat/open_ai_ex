alias OpenAI.Behaviours.{CompletionsBehaviour, EditsBehaviour, ModelsBehaviour}

Hammox.defmock(ModelsImplMock, for: ModelsBehaviour)
Application.put_env(:open_ai, :models_impl, ModelsImplMock)

Hammox.defmock(CompletionsImplMock, for: CompletionsBehaviour)
Application.put_env(:open_ai, :completions_impl, CompletionsImplMock)

Hammox.defmock(EditsImplMock, for: EditsBehaviour)
Application.put_env(:open_ai, :edits_impl, EditsImplMock)

ExUnit.start()
