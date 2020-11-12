defmodule LexOffice.Model.Invoice.LineItem do
  @moduledoc """
  Represents an Invoice Line-Item.
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
    :id => String.t,
    :type => String.t,
    :name => String.t,
    :description => String.t,
    :quantity => Float.t,
    :unitName => String.t,
    :unitPrice => LexOffice.Model.Invoice.LineItem.UnitPrice.t,
    :discountPercentage => Float.t,
    :lineItemAmount => Float.t
  }
end

defimpl Poison.Decoder, for: LexOffice.Model.Invoice.LineItem do
  import LexOffice.Deserializer
  def decode(value, options) do
    value
    |> deserialize(:unitPrice, :struct, LexOffice.Model.Invoice.LineItem.UnitPrice, options)
  end
end


defmodule LexOffice.Model.Invoice.LineItem.UnitPrice do
  @moduledoc """
  Represents an Invoice Total Price.
  """

  @derive [Poison.Encoder]
  defstruct [
    :currency,
    :netAmount,
    :grossAmount,
    :taxRatePercentage
  ]

  @type t :: %__MODULE__{
    :currency => Float.t,
    :netAmount => Float.t,
    :grossAmount => Float.t,
    :taxRatePercentage => Float.t
  }
end

defimpl Poison.Decoder, for: LexOffice.Model.Invoice.LineItem.UnitPrice do
  def decode(value, _options) do
    value
  end
end


defmodule LexOffice.Model.Invoice.TotalPrice do
  @moduledoc """
  Represents an Invoice Total Price.
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
    :currency => Float.t,
    :totalNetAmount => Float.t,
    :totalGrossAmount => Float.t,
    :totalTaxAmount => Float.t,
    :totalDiscountAbsolute => Float.t | nil,
    :totalDiscountPercentage => Float.t | nil
  }
end

defimpl Poison.Decoder, for: LexOffice.Model.Invoice.TotalPrice do
  def decode(value, _options) do
    value
  end
end


defmodule LexOffice.Model.Invoice.TaxAmount do
  @moduledoc """
  Represents an Invoice Tax Amount.
  """

  @derive [Poison.Encoder]
  defstruct [
    :taxRatePercentage,
    :taxAmount,
    :netAmount
  ]

  @type t :: %__MODULE__{
    :taxRatePercentage => Float.t,
    :taxAmount => Float.t,
    :netAmount => Float.t
  }
end

defimpl Poison.Decoder, for: LexOffice.Model.Invoice.TaxAmount do
  def decode(value, _options) do
    value
  end
end


defmodule LexOffice.Model.Invoice.TaxConditions do
  @moduledoc """
  Represents an Invoice Tax Conditions.
  """

  @derive [Poison.Encoder]
  defstruct [
    :taxType,
    :taxTypeNote
  ]

  @type t :: %__MODULE__{
    :taxType => String.t,
    :taxTypeNote => String.t | nil
  }
end

defimpl Poison.Decoder, for: LexOffice.Model.Invoice.TaxConditions do
  def decode(value, _options) do
    value
  end
end


defmodule LexOffice.Model.Invoice.PaymentConditions do
  @moduledoc """
  Represents an Invoice Payment Conditions.
  """

  @derive [Poison.Encoder]
  defstruct [
    :paymentTermLabel,
    :paymentTermDuration
  ]

  @type t :: %__MODULE__{
    :paymentTermLabel => String.t,
    :paymentTermDuration => Integer.t
  }
end

defimpl Poison.Decoder, for: LexOffice.Model.Invoice.PaymentConditions do
  def decode(value, _options) do
    value
  end
end


defmodule LexOffice.Model.Invoice.ShippingConditions do
  @moduledoc """
  Represents an Invoice Shipping Conditions.
  """

  @derive [Poison.Encoder]
  defstruct [
    :shippingDate,
    :shippingEndDate,
    :shippingType
  ]

  @type t :: %__MODULE__{
    :shippingDate => DateTime.t,
    :shippingEndDate => DateTime.t | nil,
    :shippingType => String.t
  }
end

defimpl Poison.Decoder, for: LexOffice.Model.Invoice.ShippingConditions do
  def decode(value, _options) do
    value
  end
end


defmodule LexOffice.Model.InvoiceFileIdResponse do
  @moduledoc """
  Represents an Invoice Payment Conditions.
  """

  @derive [Poison.Encoder]
  defstruct [
    :documentFileId,
  ]

  @type t :: %__MODULE__{
    :documentFileId => String.t,
  }
end

defimpl Poison.Decoder, for: LexOffice.Model.InvoiceFileIdResponse do
  def decode(value, _options) do
    value
  end
end
