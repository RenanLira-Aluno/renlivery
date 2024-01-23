defmodule Renlivery.Items.Create do
  alias Renlivery.{Error, Item, Repo}

  def call(params) do
    params
    |> Item.changeset()
    |> Repo.insert()
    |> handle_result()
  end

  defp handle_result({:ok, _item} = result), do: result

  defp handle_result({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
