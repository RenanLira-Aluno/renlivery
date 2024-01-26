defmodule RenliveryWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :renlivery

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
