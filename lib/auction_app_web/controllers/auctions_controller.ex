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
        conn
        |> send_resp(404, "")
      auction ->
        conn
        |> json(%{ auction: Auction.get!(id) })
    end
  end

  def create(conn, %{"auction" => auction_data}) do
    Map.put(auction_data, "user_id", conn.assigns.current_user.id)
    |> Auction.create
    |> case do
      {:ok, auction} ->
        conn
        |> send_resp(201, "")
      {:error, %Ecto.Changeset{} = changeset} ->
        response_with_errors(conn, changeset)
    end
  end

  def delete(conn, _) do
  end

  def update(conn, %{"auction" => auction_data, "id" => id}) do
    update_fn = fn(data, id) -> Auction.update(id, data) end

    Map.put(auction_data, "user_id", conn.assigns.current_user.id)
    |> update_fn.(id)
    |> case do
      {:ok, auction} ->
        conn
        |> send_resp(200, "")
      {:error, %Ecto.Changeset{} = changeset} ->
        response_with_errors(conn, changeset)
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
