defmodule LexOffice.Model.Address do
  @moduledoc """
  Represents an Address.
  """

  @derive [Poison.Encoder]
  defstruct [
    :id,
    :name,
    :street,
    :supplement,
    :city,
    :zip,
    :countryCode
  ]

  @type t :: %__MODULE__{
    :id => String.t,
    :name => String.t,
    :street => String.t,
    :supplement => String.t,
    :city => String.t,
    :zip => String.t,
    :countryCode => String.t
  }
end

defimpl Poison.Decoder, for: LexOffice.Model.Address do
  def decode(value, _options) do
    value
  end
end


