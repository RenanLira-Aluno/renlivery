defmodule RenliveryWeb.Auth.Guardian do
  alias Renlivery.User
  use Guardian, otp_app: :renlivery

  def subject_for_token(%User{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(%{"sub" => id}) do
    {:ok, %User{} = user} = Renlivery.get_user_by_id(id)

    {:ok, user}
  end



  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end
end
