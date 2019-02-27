defmodule AuctionApp.Models.User do
  @moduledoc """
  The user model of the application
  """

  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  require Logger

  alias AuctionApp.Models.User, as: User
  alias AuctionApp.Repo, as: Repo
  alias AuctionApp.Models.Auction

  @derive {Jason.Encoder, only: [:email, :name, :id]}
  schema "users" do
    field :email, :string
    field :name, :string

    has_many :auctions, Auction
    timestamps()
  end

  def find_by(attr, value) when is_atom(attr) do
    query = from u in User,
      where: field(u, ^attr) == ^value,
      limit: 1

    Repo.one(query)
  end

  def create_if_not_exists(user = %User{}) do
    case User.find_by(:email, user.email) do
      user when not is_nil(user) ->
        Logger.info("user #{user.email} already exists in the DB, returning it")
        {:ok, user}
      nil ->
        user = with name when is_nil(name) <- user.name do
          Map.put(user, :name, String.split(user.email, "@") |> Enum.at(0))
        else
          _ -> user
        end

        user
        |> User.changeset(%{})
        |> Repo.insert
    end
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
  end
end
