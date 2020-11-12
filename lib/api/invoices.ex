defmodule LexOffice.Invoices do
  @moduledoc """
  API calls for all endpoints tagged `Invoices`.
  """

  alias LexOffice.Connection
  import LexOffice.RequestBuilder


  @doc """
  Create a new invoice

  ## Parameters

  - connection (LexOffice.Connection): Connection to server
  - invoice (LexOffice.Model.CreateInvoice): Invoice Data
  - finalize (Boolean): [optional] Finalize this invoice and set state to open
  - opts (KeywordList): [optional] Optional parameters
  ## Returns

  {:ok, %LexOffice.Model.CreateInvoiceResponse{}} on success
  {:error, info} on failure
  """
  @spec create(Tesla.Env.client, LexOffice.Model.CreateInvoice.t, boolean(), keyword()) :: {:ok, LexOffice.Model.CreateInvoiceResponse.t} | {:error, Tesla.Env.t}
  def create(connection, invoice, finalize \\ false, _opts \\ []) do
    url_append = if finalize do "?finalize=true" else "" end
    %{}
    |> method(:post)
    |> url("/v1/invoices#{url_append}")
    |> add_param(:body, :body, invoice)
    |> Enum.into([])
    |> (&Connection.request(connection, &1)).()
    |> evaluate_response([
      { 201, %LexOffice.Model.CreateInvoiceResponse{}},
      { 400, %LexOffice.Model.ErrorMessage{}},
      { 403, %LexOffice.Model.ErrorMessage{}},
      { 500, %LexOffice.Model.ErrorMessage{}}
    ])
  end

  @doc """
  Gets a single invoice

  ## Parameters

  - connection (LexOffice.Connection): Connection to server
  - id (String): Invoice ID
  ## Returns

  {:ok, %LexOffice.Model.InvoiceResponse{}} on success
  {:error, info} on failure
  """
  @spec get(Tesla.Env.client, String.t) :: {:ok, LexOffice.Model.InvoiceResponse.t} | {:error, Tesla.Env.t}
  def get(connection, id) do
    file_id_response = %{}
    |> method(:get)
    |> url("/v1/invoices/#{id}/document")
    |> Enum.into([])
    |> (&Connection.request(connection, &1)).()
    |> evaluate_response([
      { 200, %LexOffice.Model.InvoiceFileIdResponse{}},
      { 400, %LexOffice.Model.ErrorMessage{}},
      { 403, %LexOffice.Model.ErrorMessage{}},
      { 500, %LexOffice.Model.ErrorMessage{}}
    ])

    case file_id_response do
      {:ok, file_id_response} ->
        pre_req = %{}
        |> method(:get)
        |> url("/v1/files/#{file_id_response.documentFileId}")
        |> Enum.into([])

        {:ok, req} = Connection.request(connection, pre_req)
        req = req
          |> add_param(:headers, "Accept", "application/pdf")
          |> add_param(:headers, "Content-Type", "application/pdf")

        case req do
          %Tesla.Env{:status => 200, :body => pdf} ->
            raw = Base.decode64!(pdf)
                  |> :erlang.iolist_to_binary()
                  |> :erlang.binary_to_list()
            {:ok, raw}
          other ->
            evaluate_response(other, [
              { 400, %LexOffice.Model.ErrorMessage{}},
              { 404, %LexOffice.Model.ErrorMessage{}},
              { 403, %LexOffice.Model.ErrorMessage{}},
              { 500, %LexOffice.Model.ErrorMessage{}}
            ])
        end
      other -> other
    end
  end
end
