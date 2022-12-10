alias OpenAI.Behaviours.{CompletionsBehaviour, ModelsBehaviour}

Hammox.defmock(ModelsImplMock, for: ModelsBehaviour)
Application.put_env(:open_ai, :models_impl, ModelsImplMock)

Hammox.defmock(CompletionsImplMock, for: CompletionsBehaviour)
Application.put_env(:open_ai, :completions_impl, CompletionsImplMock)

ExUnit.start()
