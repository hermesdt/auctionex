defmodule AuctionAppWeb.PageController do
  use AuctionAppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
