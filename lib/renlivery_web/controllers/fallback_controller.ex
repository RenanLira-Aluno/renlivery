defmodule RenliveryWeb.FallbackController do
  alias RenliveryWeb.ErrorJSON

  use RenliveryWeb, :controller

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ErrorJSON)
    |> render("400.json", result: result)
  end
end