defmodule LexOffice.Deserializer do
  @moduledoc """
  Helper functions for deserializing responses into models
  """
  alias Poison.Decode

  @doc """
  Update the provided model with a deserialization of a nested value
  """
  @spec deserialize(map(), atom(), :date | :list | :map | :struct, any(), keyword() | nil) ::
          map()
  def deserialize(model, field, :list, mod, options) when is_atom(field) do
    model
    |> Map.update!(field, &Decode.decode(&1, Keyword.merge(options, as: [struct(mod)])))
  end

  def deserialize(model, field, :struct, mod, options) when is_atom(field) do
    model
    |> Map.update!(field, &Decode.decode(&1, Keyword.merge(options, as: struct(mod))))
  end

  def deserialize(model, field, :map, mod, options) when is_atom(field) do
    model
    |> Map.update!(
      field,
      &Map.new(&1, fn {key, val} ->
        {key, Decode.decode(val, Keyword.merge(options, as: struct(mod)))}
      end)
    )
  end

  def deserialize(model, field, :date, _, _options) when is_atom(field) do
    value = Map.get(model, field)

    case is_binary(value) do
      true ->
        case DateTime.from_iso8601(value) do
          {:ok, datetime, _offset} ->
            Map.put(model, field, datetime)

          _ ->
            model
        end

      false ->
        model
    end
  end
end
