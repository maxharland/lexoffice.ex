# LexOffice

This package implements the [LexOffice.de](https://lexoffice.de) API in Elixir.

If you need more of their API, just launch a Pull Request.

## Installation

This package can be installed by adding `lexoffice` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:lexoffice, "~> 0.1.2"}]
end
```

## Configuration

Put the following lines into your `config.exs` or better, into your environment
configuration files like `test.exs`, `dev.exs` or `prod.exs.`.

```elixir
config :lexoffice, api_key: "<your api key>"
```

## Documentation

Documentation can be found at [https://hexdocs.pm/lexoffice](https://hexdocs.pm/lexoffice).
