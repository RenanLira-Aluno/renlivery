defmodule Renlivery.Orders.Create do
  alias Renlivery.{Error, Item, Order, Repo}

  import Ecto.Query

  def call(params) do
    with {:ok, result} <- fetch_items(params),
         {:ok, %Order{}} <- handle_insert_order(result, params) do
      {:ok, result}
    end
  end

  defp fetch_items(%{"items" => items_params}) do
    ids =
      Enum.map(items_params, & &1["id"])
      |> Enum.uniq()

    ids
    |> get_all_items_repo()
    |> case do
      {:error, _} = error -> error
      items -> check_all_items_found(ids, items, items_params)
    end
  rescue
    _ -> {:error, Error.build(:bad_request, "params invalid")}
  end

  defp fetch_items(_), do: {:error, Error.build(:bad_request, "params invalid")}

  defp handle_insert_order({:ok, items}, params) do
    params
    |> Order.changeset(items)
    |> Repo.insert()
    |> case do
      {:ok, %Order{}} = result ->
        result

      {:error, error} ->
        {:error, Error.build(:bad_request, error)}
    end
  end

  defp handle_insert_order(error, _params), do: error

  defp check_all_items_found(ids, items, items_params) do
    Enum.reduce(ids, {:ok, []}, fn id, acc ->
      {_, items_acc} = acc

      case Map.get(items, id) do
        %Item{} = item ->
          {:ok,
           multiply_quantity_items(item, items_params) ++
             items_acc}

        nil ->
          {:error, Error.build(:bad_request, "Item not found")}
      end
    end)
  end

  defp get_all_items_repo(ids) do
    from(item in Item, where: item.id in ^ids)
    |> Repo.all()
    |> Enum.reduce(%{}, fn item, acc -> Map.put(acc, item.id, item) end)
  rescue
    _ -> {:error, Error.build(:bad_request, "invalid id")}
  end

  defp multiply_quantity_items(item, items_params) do
    List.duplicate(item, Enum.find(items_params, fn i -> i["id"] == item.id end)["quantity"])
  end
end
