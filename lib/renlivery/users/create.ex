defmodule Renlivery.Users.Create do
  alias Renlivery.{Repo, User}
  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
