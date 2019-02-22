defmodule AuctionAppWeb.AuthControllerTest do
  use AuctionAppWeb.ConnCase
  use ExVCR.Mock

  alias AuctionApp.Models.User

  @ueberauth_auth %{
    credentials: %{token: "fdsnoafhnoofh08h38h"},
    info: %{
      email: "ironman@example.com",
      first_name: "Tony",
      last_name: "Stark",
      name: "Tony Stark"
    },
    provider: :google
  }

  setup do
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes/auth")
    :ok
  end

  test "GET /auth/google", %{conn: conn} do
    conn = get(conn, "/auth/google")

    assert redirected_to(conn, 302) =~
      "https://accounts.google.com/o/oauth2/v2/auth?" <>
      "client_id=#{System.get_env("GOOGLE_OAUTH_KEY")}" <>
      "&redirect_uri=http%3A%2F%2Fwww.example.com%2Fauth%2Fgoogle%2Fcallback" <>
      "&response_type=code&scope=email"
  end

  test "GET /auth/google/callback", %{conn: conn} do
    conn
    |> assign(:ueberauth_auth, @ueberauth_auth)
    |> get("/auth/google/callback")

    assert User.find_by(:email, @ueberauth_auth.info.email)
  end
end
