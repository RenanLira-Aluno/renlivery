defmodule RenliveryWeb.Utils.ParamsValidator do
  alias Renlivery.Error

  def new(schema, params \\ %{}) do
    fields_with_types =
      for {field, [type | _options]} <- schema,
          into: %{},
          do: {field, type}

    required_fields =
      for {field, [_type | opts]} when is_list(opts) <- schema,
          opts[:required],
          do: field

    defaults =
      for {field, [_type | opts]} when is_list(opts) <- schema,
          into: %{},
          do: {field, opts[:default]}

    {defaults, fields_with_types}
    |> Ecto.Changeset.cast(params, Map.keys(fields_with_types))
    |> Ecto.Changeset.validate_required(required_fields)
  end

  def apply_custom_validations(%Ecto.Changeset{} = changeset, functions) do
    Enum.reduce(functions, changeset, fn fun, acc -> fun.(acc) end)
  end

  def validate(%Ecto.Changeset{} = changeset) do
    case Ecto.Changeset.apply_action(changeset, :insert) do
      {:ok, params} ->
        {:ok, params}

      {:error, error} ->
        {:error, Error.build(:bad_request, error)}
    end
  end
end
