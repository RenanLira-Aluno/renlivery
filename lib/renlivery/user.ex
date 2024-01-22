defmodule Renlivery.User do
  alias Renlivery.User
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

  def changeset(user \\ %__MODULE__{}, params) do
    user
    |> cast(params, @required_fields)
    |> validate_required(@required_fields -- [:password])
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> validate_format(:email, ~r/@/)
    |> validate_format(:cep, ~r/^\d{5}-\d{3}$/)
    |> unique_constraint(:email)
    |> unique_constraint(:cpf)
    |> case do
      %Changeset{changes: %{password: _password}} = changeset ->
        IO.inspect(changeset)
        validade_password(changeset)

      %Changeset{data: %User{id: nil}} = changeset ->
        IO.inspect(changeset, label: "changeset")
        validade_password(changeset)

      changeset ->
        IO.inspect(changeset)
        changeset
    end
  end

  defp validade_password(changeset) do
    changeset
    |> validate_required([:password])
    |> validate_length(:password, min: 6, max: 12)
    |> put_password_hash()
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    changeset
    |> change(%{password_hash: Pbkdf2.hash_pwd_salt(password, digest: :sha256, format: :django)})
  end

  defp put_password_hash(changeset), do: changeset
end
