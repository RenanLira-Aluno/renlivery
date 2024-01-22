defmodule RenliveryWeb.UsersController do
  alias Renlivery.{Repo, User}
  alias RenliveryWeb.FallbackController
  use RenliveryWeb, :controller

  action_fallback FallbackController

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Renlivery.create_user(user_params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Renlivery.delete_user(id) do
      conn
      |> put_status(:ok)
      |> render("delete.json", user: user)
    end
  end

  def update(conn, %{"id" => _id} = params) do
    with {:ok, %User{} = user} <- Renlivery.update_user(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Renlivery.get_user_by_id(id) do
      conn
      |> put_status(:ok)
      |> render("show.json", user: user)
    end
  end

  def index(conn, _params) do
    users = Repo.all(User)
    render(conn, "index.json", users: users)
  end
end
