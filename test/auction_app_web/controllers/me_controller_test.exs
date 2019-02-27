defmodule AuctionAppWeb.MeControllerTest do
  use AuctionAppWeb.ConnCase
  use Plug.Test

  require Jason

  alias AuctionApp.Models.User

  @user_attrs [email: "alvaro@gmail.com", name: "alvaro"]

  describe "given a user that already exists on the DB" do
    test "GET /me", %{conn: conn} do
      user = struct(User, @user_attrs)
      {:ok, user} = User.create_if_not_exists(user)

      {:ok, json} = conn
      |> init_test_session(%{})
      |> put_session(:user_id, user.id)
      |> get("/me")
      |> (fn(conn) -> Jason.decode(conn.resp_body) end).()

      assert json == %{
        "email" => "alvaro@gmail.com",
        "name" => "alvaro",
        "id" => user.id
      }
    end
  end
end
