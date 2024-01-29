defimpl Canada.Can, for: Renlivery.User do
  alias Renlivery.Order
  alias Renlivery.User

  def can?(%User{}, :create, Order), do: true

  def can?(%User{} = user, :index, User), do: user.is_admin
end
