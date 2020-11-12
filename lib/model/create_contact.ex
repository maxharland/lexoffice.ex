defmodule LexOffice.Model.CreateContact do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :roles,
    :company,
    :person,
    :addresses
  ]

  @type t :: %__MODULE__{
    :roles => LexOffice.Model.Contact.Roles.t,
    :company => LexOffice.Model.Contact.Company.t,
    :person => LexOffice.Model.Contact.Person.t,
    :addresses => LexOffice.Model.Contact.Addresses.t,
  }
end

defimpl Poison.Decoder, for: LexOffice.Model.CreateContact do
  import LexOffice.Deserializer
  def decode(value, options) do
    value
    |> deserialize(:roles, :struct, LexOffice.Model.Contact.Roles, options)
    |> deserialize(:company, :struct, LexOffice.Model.Contact.Company, options)
    |> deserialize(:person, :struct, LexOffice.Model.Contact.Person, options)
    |> deserialize(:addresses, :struct, LexOffice.Model.Contact.Addresses, options)
  end
end
