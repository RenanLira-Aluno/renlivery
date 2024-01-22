defmodule Renlivery.Users.Delete do
  alias Ecto.Changeset
  alias Renlivery.{Repo, User}

  def call(id) do
    with {:ok, %User{} = user} <- Renlivery.get_user_by_id(id),
         {:ok, %User{} = user} <- Repo.delete(user) do
      {:ok, user}
    else
      {:error, %Changeset{} = changeset} -> {:error, %{status: :bad_request, result: changeset}}
      {:error, result} -> {:error, result}
    end
  end
end
