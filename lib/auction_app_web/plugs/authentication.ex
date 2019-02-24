defmodule AuctionAppWeb.Plugs.Authentication do
  import Plug.Conn

  alias AuctionApp.Models.User

  require Logger

  def login_required!(conn, _) do
    if conn.assigns[:current_user] do
      conn
    else
      conn
      |> put_status(411)
      |> halt()
    end
  end

  def assign_current_user(conn, _) do
    with user_id when not is_nil(user_id) <- get_session(conn, :user_id) do
      case user = User.find_by(:id, user_id) do
        %User{} ->
          assign(conn, :current_user, user)
        nil ->
          delete_session(conn, :user_id)
      end
    else
      nil ->
        conn
    end
  end
end
