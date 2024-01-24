defmodule RenliveryWeb.OrdersJSON do
  alias Renlivery.Order

  def render("create.json", %{order: %Order{} = order}) do
    %{
      messsage: "Order created successfully",
      data: %{
        order: order
      }
    }
  end
end
