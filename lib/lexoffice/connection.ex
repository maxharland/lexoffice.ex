defmodule LexOffice.Connection do
  @moduledoc """
  Documentation for `LexOffice.Connection` which provides low-level API functionality to the lexoffice.de API.

  **It is used for low-level communication and should not be used directly by users of this library.**
  """

  @doc "Creates a new API Connection for the given API Key by returning a pre-configured `Tesla` HTTP Client."
  @spec new(String.t() | nil) :: Tesla.Env.client()
  def new(api_key \\ Application.get_env(:lexoffice, :api_key)) do
    middleware = [
      {Tesla.Middleware.BaseUrl, "https://api.lexoffice.io"},
      {Tesla.Middleware.Timeout, timeout: 30_000},
      {Tesla.Middleware.EncodeJson, engine: Poison},
      {Tesla.Middleware.Headers,
       [
         {"User-Agent", "Elixir"},
         {"Authorization", "Bearer #{api_key}"},
         {"Accept", "application/json"},
         {"Content-Type", "application/json"}
       ]}
    ]

    Tesla.client(middleware, {Tesla.Adapter.Hackney, [timeout: 60_000]})
  end
end
