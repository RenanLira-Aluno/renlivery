defmodule RenliveryWeb.UsersJSON do
  alias Renlivery.User

  def render("create.json", %{user: %User{id: id, cpf: cpf}, token: token}) do
    %{
      message: "User created successfully",
      token: token,
      data: %{
        id: id,
        cpf: cpf
      }
    }
  end

  def render("signin.json", %{token: token}) do
    %{
      message: "User signed in successfully",
      token: token
    }
  end

  def render("show.json", %{user: user}) do
    %{
      message: "User fetched successfully",
      data: %{
        user: user
      }
    }
  end

  def render("delete.json", %{user: user}) do
    %{
      message: "User deleted successfully",
      data: %{
        user: user
      }
    }
  end

  def render("update.json", %{user: user}) do
    %{
      message: "User updated successfully",
      data: %{
        user: user
      }
    }
  end

  def render("index.json", %{users: users}) do
    %{
      message: "Users fetched successfully",
      data:
        Enum.map(users, fn user ->
          %{
            id: user.id,
            is_admin: user.is_admin,
            cpf: user.cpf
          }
        end)
    }
  end
end
