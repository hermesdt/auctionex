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
    Auction.get(id)
    |> case do
      nil ->
        send_resp(conn, 404, "")
      auction ->
        json(conn, %{ auction: Auction.get!(id) })
    end
  end

  def create(conn, %{"auction" => auction_data}) do
    Ecto.build_assoc(conn.assigns.current_user, :auctions)
    |> Auction.create(auction_data)
    |> case do
      {:ok, auction} ->
        conn
        |> put_status(201)
        |> put_flash_header(:info, "Auction created successfully")
        |> json(%{ auction: auction })
      {:error, %Ecto.Changeset{} = changeset} ->
        response_with_errors(conn, changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    auction = Auction.get(id)
    case not is_nil(auction) and auction.user_id == conn.assigns.current_user.id do
      true ->
        Auction.delete(auction)
        conn
        |> put_flash_header(:info, "Auction #{auction.title} deleted")
        |> send_resp(200, "")
      false ->
        send_resp(conn, 401, "")
    end
  end

  def update(conn, %{"auction" => auction_data, "id" => id}) do
    auction = Auction.get(id)
    case not is_nil(auction) and auction.user_id == conn.assigns.current_user.id do
      true ->
        Auction.update(auction, auction_data)
        |> case do
          {:ok, auction} ->
            conn
            |> put_flash_header(:info, "Auction updated successfully")
            |> send_resp(200, "")
          {:error, %Ecto.Changeset{} = changeset} ->
            response_with_errors(conn, changeset)
        end
      false ->
        send_resp(conn, 401, "")

    end
  end

  defp response_with_errors(conn, %Ecto.Changeset{} = changeset) do
    conn
    |> put_status(400)
    |> json(%{
        errors:
          Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
      })
  end
end
