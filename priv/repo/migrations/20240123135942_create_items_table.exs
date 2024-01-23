defmodule Renlivery.Repo.Migrations.CreateItemsTable do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :category, :string
      add :description, :string
      add :price, :decimal
      add :photo, :string

      timestamps()
    end
  end
end
