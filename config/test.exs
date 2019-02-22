use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :auction_app, AuctionAppWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :oauth2, debug: true

# Configure your database
config :auction_app, AuctionApp.Repo,
  username: "postgres",
  password: "postgres",
  database: "auction_app_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
