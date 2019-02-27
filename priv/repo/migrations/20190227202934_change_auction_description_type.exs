defmodule AuctionApp.Repo.Migrations.ChangeAuctionDescriptionType do
  use Ecto.Migration

  def change do
    alter table(:auctions) do
      modify :description, :text
    end
  end
end
