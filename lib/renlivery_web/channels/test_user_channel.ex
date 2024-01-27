defmodule RenliveryWeb.TestUserChannel do
  use RenliveryWeb, :channel

  alias RenliveryWeb.Auth.Guardian



  @impl true
  def join("test_user:lobby", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (test_user:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(%{"token" => token}) do
    with {:ok, _claims} <- Guardian.decode_and_verify(token) do
      true
    else
      _ -> false
    end
  end

  defp authorized?(_params), do: false
end
