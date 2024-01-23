defmodule RenliveryWeb.ItemsController do
  alias Renlivery.Item
  use RenliveryWeb, :controller
  action_fallback RenliveryWeb.FallbackController

  def create(conn, params) do
    with {:ok, %Item{} = item} <- Renlivery.create_item(params) do
      conn
      |> put_status(:created)
      |> render("create.json", item: item)
    end
  end
end
