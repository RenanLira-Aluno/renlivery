defmodule RenliveryWeb.ItemsController do
  alias Renlivery.Item
  alias RenliveryWeb.Utils.ParamsValidator
  use RenliveryWeb, :controller

  action_fallback RenliveryWeb.FallbackController

  def create(conn, params) do
    with {:ok, _} <- validate_create_params(params),
         {:ok, %Item{} = item} <- Renlivery.create_item(params) do
      conn
      |> put_status(:created)
      |> render("create.json", item: item)
    end
  end

  defp validate_create_params(params) do
    [
      description: [:string, required: true],
      price: [:string, required: true],
      category: [:string, required: true],
      photo: [:string, required: true]
    ]
    |> ParamsValidator.new(params)
    |> ParamsValidator.validate()
  end
end
