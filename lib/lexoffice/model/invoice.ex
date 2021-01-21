defmodule LexOffice.Model.LineItem do
  @moduledoc """
  Structure for describing invoice line item data.
  """

  @derive [Poison.Encoder]
  defstruct [
    :id,
    :type,
    :name,
    :description,
    :quantity,
    :unitName,
    :unitPrice,
    :discountPercentage,
    :lineItemAmount
  ]

  @type t :: %__MODULE__{
          :id => String.t(),
          :type => String.t(),
          :name => String.t(),
          :description => String.t(),
          :quantity => float(),
          :unitName => String.t(),
          :unitPrice => LexOffice.Model.LineItem.UnitPrice.t(),
          :discountPercentage => float(),
          :lineItemAmount => float()
        }
end

defimpl Poison.Decoder, for: LexOffice.Model.LineItem do
  import LexOffice.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:unitPrice, :struct, LexOffice.Model.LineItem.UnitPrice, options)
  end
end

defmodule LexOffice.Model.LineItem.UnitPrice do
  @moduledoc """
  Structure for specifying invoice line item unit price data.
  """

  @derive [Poison.Encoder]
  defstruct [
    :currency,
    :netAmount,
    :grossAmount,
    :taxRatePercentage
  ]

  @type t :: %__MODULE__{
          :currency => float(),
          :netAmount => float(),
          :grossAmount => float(),
          :taxRatePercentage => float()
        }
end

defimpl Poison.Decoder, for: LexOffice.Model.LineItem.UnitPrice do
  def decode(value, _options) do
    value
  end
end

defmodule LexOffice.Model.TotalPrice do
  @moduledoc """
  Structure for specifying invoice line item total price data.
  """

  @derive [Poison.Encoder]
  defstruct [
    :currency,
    :totalNetAmount,
    :totalGrossAmount,
    :totalTaxAmount,
    :totalDiscountAbsolute,
    :totalDiscountPercentage
  ]

  @type t :: %__MODULE__{
          :currency => float(),
          :totalNetAmount => float(),
          :totalGrossAmount => float(),
          :totalTaxAmount => float(),
          :totalDiscountAbsolute => float() | nil,
          :totalDiscountPercentage => float() | nil
        }
end

defimpl Poison.Decoder, for: LexOffice.Model.TotalPrice do
  def decode(value, _options) do
    value
  end
end

defmodule LexOffice.Model.TaxAmount do
  @moduledoc """
  Structure for specifying invoice tax amount data.
  """

  @derive [Poison.Encoder]
  defstruct [
    :taxRatePercentage,
    :taxAmount,
    :netAmount
  ]

  @type t :: %__MODULE__{
          :taxRatePercentage => float(),
          :taxAmount => float(),
          :netAmount => float()
        }
end

defimpl Poison.Decoder, for: LexOffice.Model.TaxAmount do
  def decode(value, _options) do
    value
  end
end

defmodule LexOffice.Model.TaxConditions do
  @moduledoc """
  Structure for specifying invoice tax condition data.
  """

  @derive [Poison.Encoder]
  defstruct [
    :taxType,
    :taxTypeNote
  ]

  @type t :: %__MODULE__{
          :taxType => String.t(),
          :taxTypeNote => String.t() | nil
        }
end

defimpl Poison.Decoder, for: LexOffice.Model.TaxConditions do
  def decode(value, _options) do
    value
  end
end

defmodule LexOffice.Model.PaymentConditions do
  @moduledoc """
  Structure for specifying invoice payment conditions.
  """

  @derive [Poison.Encoder]
  defstruct [
    :paymentTermLabel,
    :paymentTermDuration
  ]

  @type t :: %__MODULE__{
          :paymentTermLabel => String.t(),
          :paymentTermDuration => integer()
        }
end

defimpl Poison.Decoder, for: LexOffice.Model.PaymentConditions do
  def decode(value, _options) do
    value
  end
end

defmodule LexOffice.Model.ShippingConditions do
  @moduledoc """
  Structure for specifying invoice shipping conditions.
  """

  @derive [Poison.Encoder]
  defstruct [
    :shippingDate,
    :shippingEndDate,
    :shippingType
  ]

  @type t :: %__MODULE__{
          :shippingDate => DateTime.t(),
          :shippingEndDate => DateTime.t() | nil,
          :shippingType => String.t()
        }
end

defimpl Poison.Decoder, for: LexOffice.Model.ShippingConditions do
  def decode(value, _options) do
    value
  end
end

defmodule LexOffice.Model.FileIdResponse do
  @moduledoc """
  Structure for holding File ID responses.
  """

  @derive [Poison.Encoder]
  defstruct [
    :documentFileId
  ]

  @type t :: %__MODULE__{
          :documentFileId => String.t()
        }
end

defimpl Poison.Decoder, for: LexOffice.Model.FileIdResponse do
  def decode(value, _options) do
    value
  end
end
