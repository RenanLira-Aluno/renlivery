# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :canary, repo: Renlivery.Repo
config :canary, unauthorized_handler: {RenliveryWeb.Auth.ErrorHandler, :unauthorized}

config :renlivery, RenliveryWeb.Auth.Guardian,
  issuer: "renlivery",
  # Secret key. You can use `mix guardian.gen.secret` to get one
  secret_key: "QaCUOD2qn58M6FBhX9S1G1xs+sN6yGp4tVL9N8EIK3YWLGjN4DKr34yspUI5bsC6"

config :renlivery, RenliveryWeb.Auth.Pipeline,
  module: RenliveryWeb.Auth.Guardian,
  error_handler: RenliveryWeb.Auth.ErrorHandler

config :renlivery,
  ecto_repos: [Renlivery.Repo],
  generators: [timestamp_type: :utc_datetime]

config :renlivery, Renlivery.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

# Configures the endpoint
config :renlivery, RenliveryWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  render_errors: [
    formats: [json: RenliveryWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Renlivery.PubSub,
  live_view: [signing_salt: "0nk0Uod2"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :renlivery, Renlivery.Mailer, adapter: Swoosh.Adapters.Local

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
