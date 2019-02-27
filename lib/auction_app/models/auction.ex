defmodule AuctionApp.Models.Auction do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias AuctionApp.Models.Auction
  alias AuctionApp.Models.User
  alias AuctionApp.Repo

  @derive {Jason.Encoder, only: [:id, :title, :description]}
  schema "auctions" do
    field :description, :string
    field :title, :string
    belongs_to :user, User

    timestamps()
  end

  def get(id), do: Repo.get(Auction, id)
  def get!(id), do: Repo.get!(Auction, id)

  def update(id, attrs) do
    Auction.get!(id)
    |> changeset(attrs)
    |> Repo.update
  end

  def create(attrs) do
    %Auction{}
    |> changeset(attrs)
    |> Repo.insert
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
