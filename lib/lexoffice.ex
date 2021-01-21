defmodule LexOffice do
  @moduledoc """
  Documentation for `LexOffice` which provides an API for lexoffice.de.

  ## Installation

  This package can be installed by adding `lexoffice` to your list of dependencies in `mix.exs`:

  ```elixir
  def deps do
    [
      {:lexoffice, "~> 0.1.2"}
    ]
  end
  ```

  ## Configuration

  Put the following lines into your `config.exs` or better, into your environment configuration files like `test.exs`, `dev.exs` or `prod.exs.`.

  ```elixir
  config :lexoffice, api_key: "<your api key>"
  ```

  ## WebHooks in Phoenix

  Put the following lines in a file called `lexoffice_controller.ex` inside your controllers directory.

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

  ## Usage


  """
  import LexOffice.RequestBuilder
  alias LexOffice.Connection
  alias LexOffice.Model

  @doc """
  Create a new contact.

  ## Parameters

  - connection (LexOffice.Connection): Connection to server
  - contact (Model.CreateContact): Contact data
  - opts (KeywordList): [optional] Optional parameters

  ## Returns

  `{:ok, %Model.ContactResponse{}}` on success
  `{:error, info}` on failure
  """
  @spec create_contact(Model.CreateContact.t(), Tesla.Env.client() | nil) ::
          {:ok, Model.ContactResponse.t()} | {:error, Tesla.Env.t()}
  def create_contact(%Model.CreateContact{} = contact, client \\ Connection.new()) do
    %{}
    |> method(:post)
    |> url("/v1/contacts")
    |> add_param(:body, :body, contact)
    |> Enum.into([])
    |> (&Tesla.request(client, &1)).()
    |> evaluate_response([
      {200, %Model.ContactResponse{}},
      {201, %Model.ContactResponse{}},
      {400, %Model.ErrorListResponse{}},
      {403, %Model.ErrorResponse{}},
      {500, %Model.ErrorResponse{}}
    ])
  end

  @doc """
  Create a new invoice.

  ## Parameters

  - connection (LexOffice.Connection): Connection to server
  - invoice (Model.CreateInvoice): Invoice data
  - opts (KeywordList): [optional] Optional parameters

  ## Returns

  `{:ok, %Model.InvoiceResponse{}}` on success
  `{:error, info}` on failure
  """
  @spec create_invoice(Model.CreateInvoice.t(), keyword(), Tesla.Env.client() | nil) ::
          {:ok, Model.InvoiceResponse.t()} | {:error, Tesla.Env.t()}
  def create_invoice(%Model.CreateInvoice{} = invoice, query \\ [], client \\ Connection.new()) do
    optional_params = %{
      :finalize => :query
    }

    %{}
    |> method(:post)
    |> url("/v1/invoices")
    |> add_optional_params(optional_params, query)
    |> add_param(:body, :body, invoice)
    |> Enum.into([])
    |> (&Tesla.request(client, &1)).()
    |> evaluate_response([
      {201, %Model.InvoiceResponse{}},
      {400, %Model.ErrorResponse{}},
      {403, %Model.ErrorResponse{}},
      {500, %Model.ErrorResponse{}}
    ])
  end

  @doc """
  Create a new credit-note.

  ## Parameters

  - connection (LexOffice.Connection): Connection to server
  - credit_note (Model.CreateCreditNote): Credit-Note data
  - opts (KeywordList): [optional] Optional parameters

  ## Returns

  `{:ok, %Model.CreditNoteResponse{}}` on success
  `{:error, info}` on failure
  """
  @spec create_credit_note(Model.CreateCreditNote.t(), keyword(), Tesla.Env.client()) ::
          {:ok, Model.CreditNoteResponse.t()} | {:error, Tesla.Env.t()}
  def create_credit_note(
        %Model.CreateCreditNote{} = credit_note,
        query \\ [],
        client \\ Connection.new()
      ) do
    optional_params = %{
      :finalize => :query
    }

    %{}
    |> method(:post)
    |> url("/v1/credit-notes")
    |> add_optional_params(optional_params, query)
    |> add_param(:body, :body, credit_note)
    |> Enum.into([])
    |> (&Tesla.request(client, &1)).()
    |> evaluate_response([
      {201, %Model.CreditNoteResponse{}},
      {400, %Model.ErrorResponse{}},
      {403, %Model.ErrorResponse{}},
      {500, %Model.ErrorResponse{}}
    ])
  end

  @doc """
  Gets a single invoice

  ## Parameters

  - connection (LexOffice.Connection): Connection to server
  - id (String): Invoice ID

  ## Returns

  `{:ok, %Model.InvoiceResponse{}}` on success
  `{:error, info}` on failure
  """
  @spec get_invoice(String.t(), Tesla.Env.client() | nil) ::
          {:ok, Model.InvoiceResponse.t()} | {:error, Tesla.Env.t()}
  def get_invoice(id, client \\ Connection.new()) do
    file_id_response =
      %{}
      |> method(:get)
      |> url("/v1/invoices/#{id}/document")
      |> Enum.into([])
      |> (&Tesla.request(client, &1)).()
      |> evaluate_response([
        {200, %Model.FileIdResponse{}},
        {400, %Model.ErrorResponse{}},
        {403, %Model.ErrorResponse{}},
        {500, %Model.ErrorResponse{}}
      ])

    case file_id_response do
      {:ok, file_id_response} ->
        %{}
        |> method(:get)
        |> url("/v1/files/#{file_id_response.documentFileId}")
        |> Enum.into([])
        |> (&Tesla.request(client, &1)).()
        |> evaluate_response([
          {200, :base64},
          {400, %Model.ErrorResponse{}},
          {404, %Model.ErrorResponse{}},
          {403, %Model.ErrorResponse{}},
          {500, %Model.ErrorResponse{}}
        ])

      other ->
        other
    end
  end

  @doc """
  Gets a single credit-note.

  ## Parameters

  - connection (LexOffice.Connection): Connection to server
  - id (String): CreditNote ID

  ## Returns

  `{:ok, %Model.CreditNoteResponse{}}` on success
  `{:error, info}` on failure
  """
  @spec get_credit_note(String.t(), Tesla.Env.client() | nil) ::
          {:ok, Model.CreditNoteResponse.t()} | {:error, Tesla.Env.t()}
  def get_credit_note(id, client \\ Connection.new()) do
    file_id_response =
      %{}
      |> method(:get)
      |> url("/v1/credit-notes/#{id}/document")
      |> Enum.into([])
      |> (&Tesla.request(client, &1)).()
      |> evaluate_response([
        {200, %Model.FileIdResponse{}},
        {400, %Model.ErrorResponse{}},
        {403, %Model.ErrorResponse{}},
        {500, %Model.ErrorResponse{}}
      ])

    case file_id_response do
      {:ok, file_id_response} ->
        %{}
        |> method(:get)
        |> url("/v1/files/#{file_id_response.documentFileId}")
        |> Enum.into([])
        |> (&Tesla.request(client, &1)).()
        |> evaluate_response([
          {200, :base64},
          {400, %Model.ErrorResponse{}},
          {404, %Model.ErrorResponse{}},
          {403, %Model.ErrorResponse{}},
          {500, %Model.ErrorResponse{}}
        ])

      other ->
        other
    end
  end
end
