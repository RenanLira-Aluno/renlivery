defmodule Renlivery.Item do
  import Ecto.Changeset
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_fields [:category, :description, :price, :photo]
  @categories [:food, :drink, :desert]

  @derive {Jason.Encoder, only: @required_fields ++ [:id]}

  schema "items" do
    field :category, Ecto.Enum, values: @categories
    field :description, :string
    field :price, :decimal
    field :photo, :string

    timestamps()
  end

  def changeset(item \\ %__MODULE__{}, params) do
    item
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> validate_number(:price, greater_than_or_equal_to: 0)
  end
end
