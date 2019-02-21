defmodule AuctionApp.Repo do
  use Ecto.Repo,
    otp_app: :auction_app,
    adapter: Ecto.Adapters.Postgres
end
