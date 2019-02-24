defmodule AuctionAppWeb.Plugs.AuthenticationTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias AuctionApp.Models.User
  alias AuctionApp.Repo
  alias Ecto.Adapters.SQL.Sandbox

  import AuctionAppWeb.Plugs.Authentication, [:assign_current_user, :login_required!]

  @user_attrs [email: "alvaro@gmail.com", name: "alvaro"]

  setup do
    # Explicitly get a connection before each test
    :ok = Sandbox.checkout(Repo)
  end

  describe "given a user in the DB" do
    setup do
      user = struct(User, @user_attrs)
      {:ok, user} = User.create_if_not_exists(user)

      %{user: user}
    end

    test "assigns user from session", %{user: user} do
      conn = conn(:get, "/")
      |> init_test_session(%{})
      |> put_session(:user_id, user.id)
      |> assign_current_user([])

      assert conn.assigns[:current_user] == user
    end

    test "pipeline is halted if user is unlogged" do
      conn = conn(:get, "/")
      |> login_required!([])

      assert conn.status == 411
      assert conn.halted
    end

    test "pipeline isn't halted if user is logged", %{user: user} do
      conn = conn(:get, "/")
      |> init_test_session(%{})
      |> put_session(:user_id, user.id)
      |> assign_current_user([])
      |> login_required!([])

      assert not conn.halted
    end
  end

  test "removes user_id from session if user doesn't exist" do
    conn = conn(:get, "/")
    |> init_test_session(%{})
    |> put_session(:user_id, 100)
    |> assign_current_user([])

    assert conn.assigns[:current_user] == nil
    assert get_session(conn, :user_id) == nil
  end
end
