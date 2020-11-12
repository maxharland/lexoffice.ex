defmodule LexOffice.Model.CreateInvoice do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :title,
    :introduction,
    :remark,
    :language,
    :voucherStatus,
    :voucherDate,
    :address,
    :lineItems,
    :totalPrice,
    :taxAmounts,
    :taxConditions,
    :paymentConditions,
    :shippingConditions
  ]

  @type t :: %__MODULE__{
    :title => String.t,
    :introduction => String.t,
    :remark => String.t,
    :language => String.t,
    :voucherStatus => String.t,
    :voucherDate => DateTime.t,
    :address => LexOffice.Model.Address.t,
    :lineItems => list(LexOffice.Model.Invoice.LineItem.t),
    :totalPrice => LexOffice.Model.Invoice.TotalPrice.t,
    :taxAmounts => list(LexOffice.Model.Invoice.TaxAmount.t),
    :taxConditions => LexOffice.Model.Invoice.TaxConditions.t,
    :paymentConditions => LexOffice.Model.Invoice.PaymentConditions.t,
    :shippingConditions => LexOffice.Model.Invoice.ShippingConditions.t
  }
end

defimpl Poison.Decoder, for: LexOffice.Model.CreateInvoice do
  import LexOffice.Deserializer
  def decode(value, options) do
    value
    |> deserialize(:address, :struct, LexOffice.Model.Address, options)
    |> deserialize(:lineItems, :list, LexOffice.Model.Invoice.LineItem, options)
    |> deserialize(:totalPrice, :struct, LexOffice.Model.Invoice.TotalPrice, options)
    |> deserialize(:taxAmounts, :list, LexOffice.Model.Invoice.TaxAmount, options)
    |> deserialize(:taxConditions, :struct, LexOffice.Model.Invoice.TaxConditions, options)
    |> deserialize(:paymentConditions, :struct, LexOffice.Model.Invoice.PaymentConditions, options)
    |> deserialize(:shippingConditions, :struct, LexOffice.Model.Invoice.ShippingConditions, options)
  end
end
