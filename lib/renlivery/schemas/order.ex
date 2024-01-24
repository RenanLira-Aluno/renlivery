defmodule Renlivery.Order do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.Enum
  alias Renlivery.Item
  alias Renlivery.User

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:address, :comments, :payment_method, :user_id]

  @payment_methods [:money, :credit_card, :debit_card]

  schema "orders" do
    field :address, :string
    field :comments, :string
    field :payment_method, Enum, values: @payment_methods

    many_to_many :items, Item, join_through: "orders_items"
    belongs_to :user, User
  end

  def changeset(struct \\ %__MODULE__{}, params, items) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> put_assoc(:items, items)
  end
end
