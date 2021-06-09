defmodule LexOffice.Model.VoucherListResponse do
  @moduledoc """
  Structure for holding voucherlist response data.
  """

  @derive [Poison.Encoder]
  defstruct [
    :content,
    :first,
    :last,
    :totalPages,
    :totalElements,
    :numberOfElements,
    :size,
    :number
    # :sort,
  ]

  @type t :: %__MODULE__{
          :content => list(LexOffice.Model.Voucher.t()),
          :first => boolean(),
          :last => boolean(),
          :totalPages => integer(),
          :totalElements => integer(),
          :numberOfElements => integer(),
          :size => integer(),
          :number => integer()
        }
end

defimpl Poison.Decoder, for: LexOffice.Model.VoucherListResponse do
  import LexOffice.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:content, :list, LexOffice.Model.Voucher, options)
  end
end
