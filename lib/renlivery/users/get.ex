defmodule Renlivery.Users.Get do
  alias Renlivery.Error
  alias Renlivery.{Repo, User}

  def by_id(id) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build_user_not_fount_error()}
      user -> {:ok, user}
    end
  end

end
