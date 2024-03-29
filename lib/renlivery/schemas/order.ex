defmodule Renlivery.Order do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.Enum
  alias Renlivery.Item
  alias Renlivery.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [:address, :comments, :payment_method, :user_id, :items]

  @payment_methods [:money, :credit_card, :debit_card]

  @derive {Jason.Encoder, only: [:id, :address, :comments, :payment_method, :items]}

  schema "orders" do
    field :address, :string
    field :comments, :string
    field :payment_method, Enum, values: @payment_methods

    many_to_many :items, Item, join_through: "orders_items"
    belongs_to :user, User

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params, items) do
    struct
    |> cast(params, @required_params -- [:items])
    |> validate_required(@required_params)
    |> put_assoc(:items, items)
  end
end
