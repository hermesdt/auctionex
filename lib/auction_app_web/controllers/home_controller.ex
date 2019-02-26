defmodule AuctionAppWeb.HomeController do
  use AuctionAppWeb, :controller

  def index(conn, _params) do
    conn
    |> put_layout(:app)
    |> render(:index)
  end
end
