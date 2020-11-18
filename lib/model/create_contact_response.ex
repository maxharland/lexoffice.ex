defmodule LexOffice.Model.CreateContactResponse do
  @moduledoc """
  Object returned when creating an invoice.
  """

  @derive [Poison.Encoder]
  defstruct [
    :id,
    :resourceUri
  ]

  @type t :: %__MODULE__{
          :id => String.t(),
          :resourceUri => String.t()
        }
end

defimpl Poison.Decoder, for: LexOffice.Model.CreateContactResponse do
  def decode(value, _options) do
    value
  end
end
