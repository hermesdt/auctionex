defmodule AuctionAppWeb.Router do
  use AuctionAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AuctionAppWeb do
    pipe_through :browser

    get "/", PageController, :index
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

  defp assign_current_user(conn, _) do
    with user_id when not is_nil(user_id) <- get_session(conn, :user_id) do
      "as"
    else
      _ -> :error
    end
  end
end
