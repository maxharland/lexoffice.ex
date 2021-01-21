defmodule LexOffice.Model.InvoiceResponse do
  @moduledoc """
  Structure for holding invoice data.
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

defimpl Poison.Decoder, for: LexOffice.Model.InvoiceResponse do
  def decode(value, _options) do
    value
  end
end
