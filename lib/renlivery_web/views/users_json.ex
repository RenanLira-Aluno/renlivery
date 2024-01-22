defmodule RenliveryWeb.UsersJSON do
  alias Renlivery.User

  def render("create.json", %{user: %User{id: id, cpf: cpf}}) do
    %{
      message: "User created successfully",
      data: %{
        id: id,
        cpf: cpf
      }
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
            cpf: user.cpf
          }
        end)
    }
  end
end
