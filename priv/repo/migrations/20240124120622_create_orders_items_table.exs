defmodule Renlivery.Repo.Migrations.CreateOrdersItemsTable do
  use Ecto.Migration

  def change do
    create table(:orders_items, primary_key: false) do
      add :item_id, references(:items, type: :binary_id)
      add :order_id, references(:orders, type: :binary_id, on_delete: :delete_all)
    end
  end
end
