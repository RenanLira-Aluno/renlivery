defmodule RenliveryWeb.UsersController do
  alias Renlivery.{Repo,User}
  alias RenliveryWeb.FallbackController
  use RenliveryWeb, :controller


  action_fallback FallbackController
  def create(conn, %{"user" => user_params}) do
    # Renlivery.create_user(user_params)
    with {:ok, %User{} = user} <- Renlivery.create_user(user_params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end

  def index(conn, _params) do
    users = Repo.all(User)
    render(conn, "index.json", users: users)
  end

end
