defmodule Renlivery.Users.Update do
  alias Renlivery.{Repo, User}

  def call(%{id: id} = params) do
    with {:ok, user} <- Renlivery.get_user_by_id(id) do
      user
      |> User.changeset(params)
      |> Repo.update()
    end
  end
end
