defmodule RenliveryWeb.ItemsJSON do
  def render("create.json", %{item: item}) do
    %{data: item, message: "item created successfully"}
  end
end
