defmodule RenliveryWeb.Router do
  alias RenliveryWeb.Plugs.UUIDChecker
  use RenliveryWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug UUIDChecker
  end

  pipeline :auth do
    plug RenliveryWeb.Auth.Pipeline
  end

  scope "/api", RenliveryWeb do
    pipe_through :api

    get "/", WelcomeController, :index

    scope "/auth" do
      post "/signin", UsersController, :signin
      post "/signup", UsersController, :create
    end

    scope "/users" do
      pipe_through :auth
      get "/", UsersController, :index
      get "/:id", UsersController, :show
      put "/:id", UsersController, :update
      delete "/:id", UsersController, :delete
    end

    scope "/create" do
      pipe_through :auth

      post "/items", ItemsController, :create
      post "/orders", OrdersController, :create
    end

    get "gen-hash-api-pass", SiteController, :gen_hash_api_pass
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:renlivery, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: RenliveryWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
