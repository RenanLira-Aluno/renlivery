defmodule Renlivery.Users.Create do
  alias Renlivery.{Error, Repo, User}

  alias Renlivery.ApiCep.Client

  def call(%{"cep" => cep} = params) do
    with {:ok, %User{} = user} <- User.build(params),
         {:ok, _} <- Client.get_cep(cep) do
      insert_user_repo(user)
    else
      {:error, %Error{}} = error ->
        error

      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, Error.build(:bad_request, changeset)}
    end
  end

  defp insert_user_repo(user) do
    user
    |> User.changeset(%{})
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %User{} = user}), do: {:ok, user}

  defp handle_insert({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
