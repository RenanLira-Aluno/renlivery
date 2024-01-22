defmodule Renlivery.Users.Update do
  alias Renlivery.Error
  alias Renlivery.{Repo, User}

  def call(%{"id" => id} = params) do
    with {:ok, user} <- Renlivery.get_user_by_id(id),
         {:ok, user} <- user |> User.changeset(params) |> Repo.update() do
      {:ok, user}
    else
      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, Error.build(:bad_request, changeset)}

      error ->
        error
    end
  end
end
