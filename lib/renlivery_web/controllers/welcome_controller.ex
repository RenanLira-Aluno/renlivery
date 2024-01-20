defmodule RenliveryWeb.WelcomeController do
  use RenliveryWeb, :controller

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> json(%{message: "Welcome to Renlivery API"})
  end
end
