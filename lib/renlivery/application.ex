defmodule Renlivery.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      RenliveryWeb.Telemetry,
      Renlivery.Repo,
      {DNSCluster, query: Application.get_env(:renlivery, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Renlivery.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Renlivery.Finch},
      # Start a worker by calling: Renlivery.Worker.start_link(arg)
      # {Renlivery.Worker, arg},
      # Start to serve requests, typically the last entry
      RenliveryWeb.Endpoint
      # Start the report runner
      # Renlivery.Orders.ReportRunner
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Renlivery.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RenliveryWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
