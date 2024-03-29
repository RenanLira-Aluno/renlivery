defmodule Renlivery do
  @moduledoc """
  Renlivery keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  alias Renlivery.Users.Create, as: UserCreate
  alias Renlivery.Users.Delete, as: UserDelete
  alias Renlivery.Users.Get, as: UserGet
  alias Renlivery.Users.Update, as: UserUpdate
  # items --------------------------------
  alias Renlivery.Items.Create, as: ItemCreate
  # orders --------------------------------
  alias Renlivery.Orders.Create, as: OrderCreate

  defdelegate create_user(params), to: UserCreate, as: :call
  defdelegate delete_user(id), to: UserDelete, as: :call
  defdelegate get_user_by_id(id), to: UserGet, as: :by_id
  defdelegate get_user_by_email(email), to: UserGet, as: :by_email
  defdelegate update_user(params), to: UserUpdate, as: :call
  defdelegate create_item(params), to: ItemCreate, as: :call
  defdelegate create_order(params), to: OrderCreate, as: :call
end
