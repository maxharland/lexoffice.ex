defmodule LexOffice.Model.ContactResponse do
  @moduledoc """
  Structure for holding contact data.
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

defimpl Poison.Decoder, for: LexOffice.Model.ContactResponse do
  def decode(value, _options) do
    value
  end
end
