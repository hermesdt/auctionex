defmodule AuctionAppWeb.MeController do
  use AuctionAppWeb, :controller

  import AuctionAppWeb.Plugs.Authentication, [:login_required!]

  plug :login_required!

  def index(conn, _params) do
    current_user = conn.assigns[:current_user]

    conn
    |> json(current_user)
  end
end
