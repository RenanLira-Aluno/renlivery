defmodule Renlivery.User do
  alias Ecto.Changeset
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @required_fields [:name, :age, :address, :cep, :cpf, :email, :password]

  @derive {Jason.Encoder, only: [:id, :name, :age, :address, :cep, :cpf, :email]}

  schema "users" do
    field :name, :string
    field :age, :integer
    field :address, :string
    field :cep, :string
    field :cpf, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> validate_length(:password, min: 6, max: 12)
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> validate_format(:email, ~r/@/)
    |> validate_format(:cep, ~r/^\d{5}-\d{3}$/)
    |> unique_constraint(:email)
    |> unique_constraint(:cpf)
    |> put_password_hash()
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    changeset
    |> change(%{password_hash: Pbkdf2.hash_pwd_salt(password, digest: :sha256, format: :django)})
  end

  defp put_password_hash(changeset), do: changeset
end
