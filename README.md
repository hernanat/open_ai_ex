# OpenAI

![Hex.pm](https://img.shields.io/hexpm/v/open_ai)
![Hex.pm](https://img.shields.io/hexpm/dt/open_ai)

Unofficial / unaffiliated Elixir API wrapper for OpenAI's [API](https://beta.openai.com/docs/introduction).

The implementation is relatively barebones and is designed with extensibility in mind. All
  functionality is controlled via behaviours and impls which can be swapped out independently
  of one another if you desire.

## Installation

Add `open_ai` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:open_ai, "~> 0.1.3"}
  ]
end
```

## Configuration

Before using, you need to configure the library with your OpenAI credentials. For example, in
  `config/confix.exs`:

```elixir
config :open_ai,
  api_key: System.fetch_env!("OPEN_AI_API_KEY"),
  organization: System.get_env("OPEN_AI_ORGANIZATION_ID")
```

## Usage

The modules and their functions are mapped pretty much 1:1 with OpenAI's API resources, so
  the usage is relatively straightforward:

```elixir
OpenAI.Models.list()

OpenAI.Completions.create("text-davinci-003", "hello, how are you?", n: 3)

OpenAI.Images.generate("create a picture of a cute cat with a jet pack", size: "512x512")

# etc.
```

## Testing

The test suite is pretty basic at present, and really only serves to assert behaviour
  definitions. The plan is to add integration tests that can be turned on and off, but
  we haven't gotten around to that yet.

## Plans

I'd like to make both the http library (currently Finch) and the json parser (currently Jason)
  swappable to provide as much flexibility as possible, but haven't gotten around to it yet.

I'll also work on getting CI setup in the coming days / weeks.

## Documentation

The documentation is still a work in progress but I've tried to do most of it as I've gone
  along. You can view it [here](https://hexdocs.pm/open_ai/api-reference.html).

## Contributing

No formal contributing guidelines yet. The basic things I'd ask are:

- Don't be an a--hole
- If you're reporting a bug, please provide steps to reproduce as well as details about
  your environment (i.e. elixir version, package version, etc.)
