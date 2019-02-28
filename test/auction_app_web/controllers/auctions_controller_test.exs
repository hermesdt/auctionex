defmodule AuctionAppWeb.AuctionsControllerTest do
  use AuctionAppWeb.ConnCase
  use Plug.Test

  alias AuctionApp.Models.{Auction, User}
  alias AuctionApp.Repo

  describe "GET /" do
    setup [:create_users, :create_auctions]

    test "returns all auctions in the DB", %{conn: conn} do
      %{"auctions" => auctions} = conn
      |> get("/auctions")
      |> json_response(200)

      num_auctions = Repo.aggregate(Auction, :count, :id)
      assert Enum.count(auctions) == num_auctions
    end
  end

  describe "GET /auctions/:id" do
    setup [:create_users, :create_auctions]

    test "given a existing auction returns it as json",
          %{auctions: [auction | _], conn: conn} do

      response = conn
      |> get("/auctions/#{auction.id}")
      |> json_response(200)

      assert response == %{
        "auction" => %{
          "description" => "u1_d1",
          "id" => auction.id,
          "title" => "u1_t1",
          "user_id" => auction.user_id
        }
      }
    end

    test "returns 404 if the id isn't present in the DB", %{conn: conn} do
      %{status: status} = conn
      |> get("/auctions/1")

      assert status == 404
    end
  end

  describe "POST /auctions" do
    setup [:create_users]

    test "creates an auction in the DB belogning to the current user",
        %{users: [user | _], conn: conn} do

      data = %{title: "t1", description: "d1"}
      assert Repo.aggregate(Auction, :count, :id) == 0

      %{"auction" => %{"id" => id}} = conn
      |> login_as_user(user)
      |> post("/auctions", %{auction: data})
      |> json_response(201)

      assert Auction.get!(id).user_id == user.id
    end

    test "receiving incorrect input responds with 400",
        %{users: [user | _], conn: conn} do

      data = %{title: "t1"}
      assert Repo.aggregate(Auction, :count, :id) == 0

      %{status: 400} = conn
      |> login_as_user(user)
      |> post("/auctions", %{auction: data})

      assert Repo.aggregate(Auction, :count, :id) == 0
    end

    test "unlogged user creating an auction responds with an error", %{conn: conn} do
      %{status: 401} = conn
      |> post("/auctions", %{auction: %{title: "t1", description: "d1"}})

      assert Repo.aggregate(Auction, :count, :id) == 0
    end
  end

  describe "DELETE /auctions/:id" do
    setup [:create_users, :create_auctions]

    test "deleting an auction responds with 200",
          %{users: [user | _], auctions: [auction | _], conn: conn} do
      conn = conn
      |> login_as_user(user)
      |> delete("/auctions/#{auction.id}")

      assert conn.status == 200
      assert is_nil(Auction.get(auction.id))
    end

    test "deleting an auction from another user responds with 401",
          %{users: [_, other_user], auctions: [auction | _], conn: conn} do
      conn = conn
      |> login_as_user(other_user)
      |> delete("/auctions/#{auction.id}")

      assert conn.status == 401
      assert Auction.get(auction.id)
    end
  end

  describe "PUT /auctions/:id" do
    setup [:create_users, :create_auctions]

    test "updating an auction responds with 200",
          %{users: [user | _], auctions: [auction | _], conn: conn} do
      new_data = %{title: "some title", description: "some desc"}

      conn = conn
      |> login_as_user(user)
      |> put("/auctions/#{auction.id}", %{auction: new_data})

      assert conn.status == 200
      assert Auction.get!(auction.id).title == new_data.title
    end

    test "updating an auction without description responds with 400",
    %{users: [user | _], auctions: [auction | _], conn: conn} do
      new_data = %{title: "some title", description: nil}

      conn = conn
      |> login_as_user(user)
      |> put("/auctions/#{auction.id}", %{auction: new_data})

      assert json_response(conn, 400) == %{"errors" => %{"description" => ["can't be blank"]}}
      assert Auction.get!(auction.id).title == "u1_t1"
    end

    test "updating an auction from another user responds with 401",
    %{users: [_, other_user], auctions: [auction | _], conn: conn} do
      new_data = %{title: "some title", description: nil}

      conn = conn
      |> login_as_user(other_user)
      |> put("/auctions/#{auction.id}", %{auction: new_data})

      assert conn.status == 401
      assert Auction.get!(auction.id).title == "u1_t1"
    end
  end

  defp create_users(_) do
    {:ok, user1} = %User{email: "user1@mail.com"} |> Repo.insert
    {:ok, user2} = %User{email: "user2@mail.com"} |> Repo.insert

    {:ok, %{users: [user1, user2]}}
  end

  defp create_auctions(%{users: [user1, user2]}) do
    auctions = [
      user1
      |> Ecto.build_assoc(:auctions)
      |> Auction.changeset(%{title: "u1_t1", description: "u1_d1"}),

      user
      |> Ecto.build_assoc(:auctions)
      |> Auction.changeset(%{title: "u1_t2", description: "u1_d2"}),

      user2
      |> Ecto.build_assoc(:auctions)
      |> Auction.changeset(%{title: "u2_t1", description: "u2_d1"})
    ]
    |> Enum.map(fn(auction) ->
      {:ok, auction} = Auction.create(auction, %{})
      auction
    end)

    {:ok, %{auctions: auctions}}
  end

  defp login_as_user conn, user do
    conn
    |> init_test_session(%{})
    |> put_session(:user_id, user.id)
  end
end
