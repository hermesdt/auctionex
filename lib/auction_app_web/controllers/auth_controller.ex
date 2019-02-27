defmodule AuctionAppWeb.AuthController do
    use AuctionAppWeb, :controller
    alias AuctionApp.Models.User

    plug Ueberauth

    def callback(conn = %{assigns: assigns = %{ueberauth_auth: _auth}}, _) do
      {:ok, user} = create_user(conn)

      conn
      |> put_session(:user_id, user.id)
      |> redirect(to: "/")
    end

    def callback(conn = %{assigns: %{ueberauth_failure: failure}}, _) do
      text(conn, "Something went wrong #{inspect(failure)}")
    end

    defp create_user(conn) do
      User.create_if_not_exists(
        %User{
          email: get_email(conn),
          name: get_name(conn)
        }
      )
    end

    defp get_email(conn) do
      conn.assigns.ueberauth_auth.info.email
    end

    defp get_name(conn) do
      conn.assigns.ueberauth_auth.info.name
    end
  end
