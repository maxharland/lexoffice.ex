defmodule LexOffice.Model.CreditNoteResponse do
  @moduledoc """
  Structure for holding credit note data.
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

defimpl Poison.Decoder, for: LexOffice.Model.CreditNoteResponse do
  def decode(value, _options) do
    value
  end
end
