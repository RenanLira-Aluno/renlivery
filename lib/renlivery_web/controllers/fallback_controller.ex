defmodule RenliveryWeb.FallbackController do
  alias Renlivery.Error
  alias RenliveryWeb.ErrorJSON

  use RenliveryWeb, :controller

  def call(conn, {:error, %Error{status: status, result: result}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorJSON)
    |> render("error.json", result: result)
  end
end
