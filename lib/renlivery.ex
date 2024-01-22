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

  defdelegate create_user(params), to: UserCreate, as: :call
  defdelegate delete_user(id), to: UserDelete, as: :call
  defdelegate get_user_by_id(id), to: UserGet, as: :by_id
end
