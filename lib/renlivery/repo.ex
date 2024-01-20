defmodule Renlivery.Repo do
  use Ecto.Repo,
    otp_app: :renlivery,
    adapter: Ecto.Adapters.Postgres
end
