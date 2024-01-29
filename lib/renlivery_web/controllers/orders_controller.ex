defmodule RenliveryWeb.OrdersController do
  use RenliveryWeb, :controller
  import Canary.Plugs

  alias Renlivery.Order
  alias RenliveryWeb.Auth.Guardian

  plug :authorize_resource, model: Order

  action_fallback RenliveryWeb.FallbackController

  def create(conn, params) do
    IO.inspect(conn)
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
