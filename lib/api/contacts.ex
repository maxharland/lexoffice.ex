defmodule LexOffice.Contacts do
  @moduledoc """
  API calls for all endpoints tagged `Contacts`.
  """

  alias LexOffice.Connection
  import LexOffice.RequestBuilder


  @doc """
  Create a new contact

  ## Parameters

  - connection (LexOffice.Connection): Connection to server
  - contact (LexOffice.Model.CreateContact): Contact Data
  - opts (KeywordList): [optional] Optional parameters
  ## Returns

  {:ok, %LexOffice.Model.CreateContactResponse{}} on success
  {:error, info} on failure
  """
  @spec create(Tesla.Env.client, LexOffice.Model.CreateContact.t, keyword()) :: {:ok, LexOffice.Model.CreateContactResponse.t} | {:error, Tesla.Env.t}
  def create(connection, contact, _opts \\ []) do
    %{}
    |> method(:post)
    |> url("/v1/contacts")
    |> add_param(:body, :body, contact)
    |> Enum.into([])
    |> (&Connection.request(connection, &1)).()
    |> evaluate_response([
      { 201, %LexOffice.Model.CreateContactResponse{}},
      { 400, %LexOffice.Model.ErrorMessage{}},
      { 403, %LexOffice.Model.ErrorMessage{}},
      { 500, %LexOffice.Model.ErrorMessage{}}
    ])
  end
end
