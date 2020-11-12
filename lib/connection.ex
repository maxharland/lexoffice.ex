defmodule LexOffice.Connection do
  @moduledoc """
  Handle Tesla connections for LexOffice.
  """

  use Tesla

  adapter Tesla.Adapter.Hackney

  def new do
    middlewares = [
      #{Tesla.Middleware.BaseUrl, "http://localhost:1500"},
      {Tesla.Middleware.BaseUrl, "https://api.lexoffice.io"},
      {Tesla.Middleware.Headers, [
        {"User-Agent", "Elixir"},
        {"Authorization", "Bearer #{Application.get_env(:lexoffice, :api_key)}"},
        {"Accept", "application/json"},
        {"Content-Type", "application/json"},
      ]},
      {Tesla.Middleware.Timeout, timeout: 30_000},
      {Tesla.Middleware.EncodeJson, engine: Poison},
    ]

    Tesla.client(middlewares)
  end
end
