defmodule RenliveryWeb.Auth.ErrorHandler do
  alias Guardian.Plug.ErrorHandler
  alias Plug.Conn

  @behaviour ErrorHandler

  def auth_error(conn, {error, _reason}, _opts) do
    body = Jason.encode!(%{message: to_string(error)})

    conn
    |> Conn.send_resp(401, body)
  end

  def unauthorized(conn) do
    body = Jason.encode!(%{message: "Unauthorized"})

    conn
    |> Conn.send_resp(403, body)
    |> Conn.halt()
  end
end
