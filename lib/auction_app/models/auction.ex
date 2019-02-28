defmodule AuctionApp.Models.Auction do
  @moduledoc """
  The auction model of the application
  """

  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias AuctionApp.Models.Auction
  alias AuctionApp.Models.User
  alias AuctionApp.Repo

  @derive {Jason.Encoder, only: [:id, :title, :description, :user_id]}
  schema "auctions" do
    field :description, :string
    field :title, :string

    belongs_to :user, User, foreign_key: :user_id

    timestamps()
  end

  def get(id), do: Repo.get(Auction, id)
  def get!(id), do: Repo.get!(Auction, id)

  def update(auction, attrs) do
    auction
    |> changeset(attrs)
    |> Repo.update
  end

  def create(auction, attrs) do
    auction
    |> changeset(attrs)
    |> Repo.insert
  end

  def delete(auction) do
    auction |> Repo.delete
  end

  def all do
    query = from a in Auction,
      order_by: a.id
    Repo.all(query)
  end

  @doc false
  def changeset(auction, attrs) do
    auction
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
  end
end
