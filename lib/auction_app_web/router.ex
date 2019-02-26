defmodule AuctionAppWeb.Router do
  use AuctionAppWeb, :router
  import AuctionAppWeb.Plugs.Authentication, [:assign_current_user]

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    # plug :fetch_flash
    # plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :assign_current_user
  end

  scope "/", AuctionAppWeb do
    pipe_through :browser

    get "/me", MeController, :index
  end

  scope "/auth", AuctionAppWeb do
    pipe_through :browser

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end

  # Other scopes may use custom stacks.
  # scope "/api", AuctionAppWeb do
  #   pipe_through :api
  # end
end
