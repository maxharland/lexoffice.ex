defmodule LexOffice.PhoenixController do
  @moduledoc """
  Implements a PhoenixController that can be easily wired up and used.

  ## Examples

  ```elixir
  defmodule YourAppWeb.LexOfficeController do
    use LexOffice.PhoenixController

    def handle_event(org_id, "payment.changed", resource_id, date) do
      id
      |> Documents.get_by_pandadoc_id!()
      |> Documents.update_document(%{status: status})
    end

    def handle_event(org_id, type, resource_id, date) do
      IO.puts "i do not handle LexOffice requests of type \#{type} yet."
    end
  end
  ```

  Put the following lines into your `router.ex` and configure the WebHook in the lexoffice portal.

  ```elixir
    post "/callbacks/lexoffice", YourAppWeb.LexOfficeController, :webhook
  ```

  """

  @doc """
  Triggers when a LexOffice webhook arrives.
  """
  @callback handle_event(String.t(), String.t(), String.t(), map(), DateTime.t()) :: any()

  defmacro __using__(_) do
    quote do
      @moduledoc "Implements a PhoenixController with callbacks for LexOffice."
      @behaviour LexOffice.PhoenixController
      require Logger
      use Phoenix.Controller
      alias Plug.Conn

      @doc "default webhook that should match."
      @spec webhook(Conn.t(), map()) :: Conn.t()
      def webhook(conn, %{
            "_json" => %{
              "eventType" => type,
              "organizationId" => org_id,
              "resourceId" => resource_id,
              "eventDate" => event_date
            }
          }) do
        spawn(fn -> handle_event(type, org_id, resource_id, event_date) end)
        Conn.send_resp(conn, 200, "")
      end

      @doc "fallback webhook that should not match."
      @spec webhook(Conn.t(), map()) :: Conn.t()
      def webhook(conn, _), do: Conn.send_resp(conn, 406, "")
    end
  end
end
