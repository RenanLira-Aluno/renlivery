defmodule RenliveryWeb.UsersController do
  use RenliveryWeb, :controller

  import Canary.Plugs

  alias RenliveryWeb.Auth.Guardian
  alias Renlivery.{Error, Repo, User}
  alias RenliveryWeb.FallbackController

  plug :authorize_resource, model: User, except: [:create]
  action_fallback FallbackController

  def create(conn, user_params) do
    with {:ok, %User{} = user} <- Renlivery.create_user(user_params),
         {:ok, token, _} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user, token: token)
    end
  end

  def signin(conn, %{"email" => email, "password" => password}) do
    with {:ok, %User{password_hash: password_hash} = user} <- Renlivery.get_user_by_email(email),
         true <- Pbkdf2.verify_pass(password, password_hash),
         {:ok, token, _} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:ok)
      |> render("signin.json", token: token)
    else
      _ -> {:error, Error.build(:unauthorized, "Invalid credentials")}
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
