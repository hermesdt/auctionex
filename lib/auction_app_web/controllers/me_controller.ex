defmodule AuctionAppWeb.MeController do
  use AuctionAppWeb, :controller

  def index(conn, _params) do
    current_user = conn.assigns[:current_user]
    require IEx; IEx.pry
    conn
    |> json(current_user)
  end
end
