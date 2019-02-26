defmodule AuctionApp.Repo.Migrations.CreateAuctions do
  use Ecto.Migration

  def change do
    create table(:auctions) do
      add :title, :string
      add :description, :string

      timestamps()
    end

  end
end
