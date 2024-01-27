defimpl Canada.Can, for: User do
  alias Renlivery.Order
  alias Renlivery.User

  def can?(%User{id: user_id}, action, %Order{user_id: user_id}) when action in [:show],
    do: true

  def can?(%User{}, :create, %Order{}), do: false
  def can?(%User{id: _user_id}, _, _), do: false
end
