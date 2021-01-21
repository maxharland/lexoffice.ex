defmodule LexOffice.Model.CreateCreditNote do
  @moduledoc """
  Structure for holding data when creating an invoice.
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
          :title => String.t(),
          :introduction => String.t(),
          :remark => String.t(),
          :language => String.t(),
          :voucherStatus => String.t(),
          :voucherDate => DateTime.t(),
          :address => LexOffice.Model.Address.t(),
          :lineItems => list(LexOffice.Model.LineItem.t()),
          :totalPrice => LexOffice.Model.TotalPrice.t(),
          :taxAmounts => list(LexOffice.Model.TaxAmount.t()),
          :taxConditions => LexOffice.Model.TaxConditions.t(),
          :paymentConditions => LexOffice.Model.PaymentConditions.t(),
          :shippingConditions => LexOffice.Model.ShippingConditions.t()
        }
end

defimpl Poison.Decoder, for: LexOffice.Model.CreateCreditNote do
  import LexOffice.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:address, :struct, LexOffice.Model.Address, options)
    |> deserialize(:lineItems, :list, LexOffice.Model.LineItem, options)
    |> deserialize(:totalPrice, :struct, LexOffice.Model.TotalPrice, options)
    |> deserialize(:taxAmounts, :list, LexOffice.Model.TaxAmount, options)
    |> deserialize(:taxConditions, :struct, LexOffice.Model.TaxConditions, options)
    |> deserialize(:paymentConditions, :struct, LexOffice.Model.PaymentConditions, options)
    |> deserialize(:shippingConditions, :struct, LexOffice.Model.ShippingConditions, options)
  end
end
