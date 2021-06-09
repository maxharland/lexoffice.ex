defmodule LexOffice.Model.Voucher do
  @moduledoc """
  Structure for holding voucher information given by list.
  """

  @derive [Poison.Encoder]
  defstruct [
    :id,
    :voucherType,
    :voucherStatus,
    :voucherDate,
    :voucherNumber,
    :dueDate,
    :contactName,
    :totalAmount,
    :openAmount,
    :currency,
    :archived
  ]

  @type t :: %__MODULE__{
          :id => String.t(),
          :voucherType => String.t(),
          :voucherStatus => String.t(),
          :voucherNumber => String.t(),
          :voucherDate => DateTime.t(),
          :contactName => String.t(),
          :totalAmount => float(),
          :openAmount => float(),
          :currency => String.t(),
          :archived => boolean()
        }
end

defimpl Poison.Decoder, for: LexOffice.Model.Voucher do
  def decode(value, _options) do
    value
  end
end
