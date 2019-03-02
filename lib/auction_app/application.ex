defmodule AuctionApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    load_env()

    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      AuctionApp.Repo,
      # Start the endpoint when the application starts
      AuctionAppWeb.Endpoint
      # Starts a worker by calling: AuctionApp.Worker.start_link(arg)
      # {AuctionApp.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AuctionApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    AuctionAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp load_env do
    if Mix.env != :prod do
      Envy.load([".env"])
      Envy.reload_config
    end
  end
end
