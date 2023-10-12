defmodule LexOffice.Model.CreateContact do
  @moduledoc """
  Structure for creating a new contact.
  """

  @derive [Poison.Encoder]
  defstruct [
    :roles,
    :company,
    :person,
    :addresses,
    :emailAddresses,
    :phoneNumbers
  ]

  @type t :: %__MODULE__{
          :roles => LexOffice.Model.Contact.Roles.t(),
          :company => LexOffice.Model.Contact.Company.t(),
          :person => LexOffice.Model.Contact.Person.t(),
          :addresses => LexOffice.Model.Contact.Addresses.t(),
          :emailAddresses => LexOffice.Model.Contact.EmailAddresses.t(),
          :phoneNumbers => LexOffice.Model.Contact.PhoneNumbers.t()
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
    |> deserialize(:emailAddresses, :struct, LexOffice.Model.Contact.EmailAddresses, options)
    |> deserialize(:phoneNumbers, :struct, LexOffice.Model.Contact.PhoneNumbers, options)
  end
end
