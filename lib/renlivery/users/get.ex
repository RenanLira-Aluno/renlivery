defmodule Renlivery.Users.Get do
  alias Renlivery.Error
  alias Renlivery.{Repo, User}

  def by_id(id) do
    with {:ok, id} <- Ecto.UUID.cast(id),
         %User{} = user <- Repo.get(User, id) do
      {:ok, user}
    else
      error -> handle_error(error)
    end
  end

  defp handle_error(:error), do: {:error, Error.build_id_invalid_error()}
  defp handle_error(nil), do: {:error, Error.build_user_not_fount_error()}
end
