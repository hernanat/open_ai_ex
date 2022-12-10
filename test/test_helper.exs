alias OpenAI.Behaviours.{ModelsBehaviour}
Hammox.defmock(ModelsImplMock, for: ModelsBehaviour)
Application.put_env(:open_ai, :models_impl, ModelsImplMock)

ExUnit.start()
