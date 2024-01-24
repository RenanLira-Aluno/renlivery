defmodule Renlivery.Orders.Create do
  alias Renlivery.Error
  alias Renlivery.Item
  alias Renlivery.Repo
  import Ecto.Query

  def call(params) do
    params
    |> fetch_items()
  end

  defp fetch_items(%{"items" => items_params}) do
    ids =
      Enum.map(items_params, & &1["id"])
      |> Enum.uniq()

    items = get_all_items(ids)

    Enum.reduce(ids, {:ok, []}, fn id, acc ->
      {_, items_acc} = acc

      case Map.get(items, id) do
        %Item{} = item -> {:ok, [item | items_acc]}
        nil -> handle_error()
      end
    end)
  end

  defp get_all_items(ids) do
    from(item in Item, where: item.id in ^ids)
    |> Repo.all()
    |> Enum.reduce(%{}, fn item, acc -> Map.put(acc, item.id, item) end)
  end

  defp handle_error() do
    {:error, Error.build(:bad_request, "Item not found")}
  end
end
