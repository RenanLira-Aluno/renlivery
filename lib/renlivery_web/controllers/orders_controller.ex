defmodule RenliveryWeb.OrdersController do
  alias Renlivery.Order
  use RenliveryWeb, :controller

  def create(conn, params) do
    with {:ok, %Order{} = order} <- Renlivery.create_order(params) do
      conn
      |> put_status(:created)
      |> render("create.json", order: order)
    end
  end
end
