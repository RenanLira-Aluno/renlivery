defimpl Canada.Can, for: Renlivery.User do
  alias Renlivery.Order
  alias Renlivery.User


  # ORDERS
  def can?(%User{}, :create, Order), do: true

  # USERS
  def can?(%User{} = user, :index, User), do: user.is_admin

  #ITEMS
  def can?(%User{} = user, :create, Item), do: user.is_admin
end
