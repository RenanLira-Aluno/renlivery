defmodule RenliveryWeb.Plugs.UUIDChecker do
  alias Plug.Conn
  alias Ecto.UUID
  import Plug.Conn

  def init(default), do: default

  def call(%Conn{params: %{"id" => id}} = conn, _op) do
    case UUID.cast(id) do
      {:ok, _} -> conn
      :error -> render_error(conn)
    end
  end

  def call(conn, _op), do: conn

  defp render_error(conn) do
    error =
      Jason.encode!(%{
        message: "Invalid UUID"
      })

    conn
    |> send_resp(400, error)
    |> halt()
  end
end
