defmodule AuctionApp.Models.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  import Logger

  alias AuctionApp.Repo, as: Repo
  alias AuctionApp.Models.User, as: User

  schema "users" do
    field :email, :string
    field :name, :string

    timestamps()
  end

  def find_by(attr, value) when is_atom(attr) do
    query = from u in User,
      where: field(u, ^attr) == ^value,
      limit: 1

    Repo.one(query)
  end

  def create_if_not_exists(%User{} = user) do
    case User.find_by(:email, user.email) do
      user when not is_nil(user) ->
        Logger.info("user #{user.email} already exists in the DB, returning it")
        {:ok, user}
      nil ->
        User.changeset(user, %{})
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
