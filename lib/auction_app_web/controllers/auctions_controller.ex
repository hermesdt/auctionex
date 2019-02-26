defmodule AuctionAppWeb.AuctionsController do
  use AuctionAppWeb, :controller
  alias AuctionApp.Models.Auction

  import AuctionAppWeb.Plugs.Authentication, [:login_required!]
  import AuctionAppWeb.ErrorHelpers, [:translate_error/1]

  plug :login_required! when action in [:new, :create, :delete, :edit, :update]

  def index(conn, _) do
    conn
    |> json(%{ auctions: Auction.all })
  end

  def show(conn, %{"id" => id}) do
    conn
    |> json(%{ auctions: Auction.get!(id) })
  end

  def create(conn, %{"auction" => auction_data}) do
    Map.put(auction_data, "user_id", conn.assigns.current_user.id)
    |> Auction.create!
    |> case do
      {:ok, auction} ->
        conn
        |> send_resp(201, "")
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(400)
        |> json(%{
            errors:
              Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
          })
    end
  end

  def delete(conn, _) do

  end

  def update(conn, _) do

  end
end
