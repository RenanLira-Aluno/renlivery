defmodule RenliveryWeb.OrdersController do


  alias Renlivery.Order
  alias RenliveryWeb.Auth.Guardian
  use RenliveryWeb, :controller


  action_fallback RenliveryWeb.FallbackController

  def create(conn, params) do
    user = Guardian.Plug.current_resource(conn)

    params =
      params
      |> Map.put("user_id", user.id)
      |> Map.put("address", user.address)

    with {:ok, %Order{} = order} <- Renlivery.create_order(params) do
      conn
      |> put_status(:created)
      |> render("create.json", order: order)
    end
  end
end
