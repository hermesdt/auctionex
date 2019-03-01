use Mix.Config

config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: System.get_env("GOOGLE_OAUTH_KEY"),
  client_secret: System.get_env("GOOGLE_OAUTH_SECRET")
  # redirect_uri: "http://auctionex.com/auth/google/callback"