defmodule Renlivery.Repo.Migrations.CreateOrderTable do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :address, :string
      add :comments, :string
      add :payment_method, :string
      add :user_id, references(:users, type: :binary_id)

      timestamps()
    end
  end
end
