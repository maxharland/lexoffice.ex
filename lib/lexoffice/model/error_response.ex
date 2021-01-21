defmodule LexOffice.Model.ErrorResponse do
  @moduledoc """
  Structure with additional information about an API Error response.
  """

  @derive [Poison.Encoder]
  defstruct [
    :message
  ]

  @type t :: %__MODULE__{
          :message => String.t()
        }
end

defimpl Poison.Decoder, for: LexOffice.Model.ErrorResponse do
  def decode(value, _options) do
    value
  end
end

defmodule LexOffice.Model.ErrorListResponse do
  @moduledoc """
  Structure with additional information about a list of API Errors in a single response.
  """

  @derive [Poison.Encoder]
  defstruct [
    :IssueList
  ]

  @type t :: %__MODULE__{
          :IssueList => list(LexOffice.Model.ErrorListEntry.t())
        }
end

defimpl Poison.Decoder, for: LexOffice.Model.ErrorListResponse do
  import LexOffice.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:IssueList, :list, LexOffice.Model.ErrorListEntry, options)
  end
end

defmodule LexOffice.Model.ErrorListEntry do
  @moduledoc """
  Structure with additional information about an API Error-List-Entry.
  """

  @derive [Poison.Encoder]
  defstruct [
    :i18nKey,
    :source,
    :type
  ]

  @type t :: %__MODULE__{
          :i18nKey => String.t(),
          :source => String.t(),
          :type => String.t()
        }
end

defimpl Poison.Decoder, for: LexOffice.Model.ErrorListEntry do
  def decode(value, _options) do
    value
  end
end
