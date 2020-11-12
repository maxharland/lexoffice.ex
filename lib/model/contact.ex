defmodule LexOffice.Model.Contact.Role do
  @moduledoc """
  Represents an Contact Role.
  """

  @derive [Poison.Encoder]
  defstruct [
    :number
  ]

  @type t :: %__MODULE__{
    :number => String.t | nil
  }
end

defimpl Poison.Decoder, for: LexOffice.Model.Contact.Role do
  def decode(value, _options) do
    value
  end
end


defmodule LexOffice.Model.Contact.Roles do
  @moduledoc """
  Represents an Contact Roles.
  """

  @derive [Poison.Encoder]
  defstruct [
    :customer,
    :vendor
  ]

  @type t :: %__MODULE__{
    :customer => LexOffice.Model.Contact.Role.t | nil,
    :vendor => LexOffice.Model.Contact.Role.t | nil,
  }
end

defimpl Poison.Decoder, for: LexOffice.Model.Contact.Roles do
  import LexOffice.Deserializer
  def decode(value, options) do
    value
    |> deserialize(:customer, :struct, LexOffice.Model.Contact.Role, options)
    |> deserialize(:vendor, :struct, LexOffice.Model.Contact.Role, options)
  end
end


defmodule LexOffice.Model.Contact.Person do
  @moduledoc """
  Represents an Contact Person.
  """

  @derive [Poison.Encoder]
  defstruct [
    :salutation,
    :firstName,
    :lastName,
  ]

  @type t :: %__MODULE__{
    :salutation => String.t | nil,
    :firstName => String.t,
    :lastName => String.t,
  }
end

defimpl Poison.Decoder, for: LexOffice.Model.Contact.Person do
  def decode(value, _options) do
    value
  end
end


defmodule LexOffice.Model.Contact.Company do
  @moduledoc """
  Represents an Contact Company.
  """

  @derive [Poison.Encoder]
  defstruct [
    :name,
    :taxNumber,
    :vatRegistrationId,
    :allowTaxFreeInvoices
  ]

  @type t :: %__MODULE__{
    :name => String.t,
    :taxNumber => String.t,
    :vatRegistrationId => String.t,
    :allowTaxFreeInvoices => Boolean.t
  }
end

defimpl Poison.Decoder, for: LexOffice.Model.Contact.Company do
  def decode(value, _options) do
    value
  end
end


defmodule LexOffice.Model.Contact.Address do
  @moduledoc """
  Represents an Contact Address.
  """

  @derive [Poison.Encoder]
  defstruct [
    :street,
    :supplement,
    :zip,
    :city,
    :countryCode
  ]

  @type t :: %__MODULE__{
    :street => String.t,
    :supplement => String.t | nil,
    :zip => String.t,
    :city => String.t,
    :countryCode => String.t
  }
end

defimpl Poison.Decoder, for: LexOffice.Model.Contact.Address do
  def decode(value, _options) do
    value
  end
end


defmodule LexOffice.Model.Contact.Addresses do
  @moduledoc """
  Represents an Contact Address-Map.
  """

  @derive [Poison.Encoder]
  defstruct [
    :billing,
    :shipping
  ]

  @type t :: %__MODULE__{
    :billing => LexOffice.Model.Contact.Address.t,
    :shipping => LexOffice.Model.Contact.Address.t | nil,
  }
end

defimpl Poison.Decoder, for: LexOffice.Model.Contact.Roles do
  import LexOffice.Deserializer
  def decode(value, options) do
    value
    |> deserialize(:billing, :struct, LexOffice.Model.Contact.Address, options)
    |> deserialize(:shipping, :struct, LexOffice.Model.Contact.Address, options)
  end
end
