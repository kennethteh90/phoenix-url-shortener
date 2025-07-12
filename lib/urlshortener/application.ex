defmodule Urlshortener.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      UrlshortenerWeb.Telemetry,
      # Start the Ecto repository
      Urlshortener.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Urlshortener.PubSub},
      # Start Finch
      {Finch, name: Urlshortener.Finch},
      # Start the endpoint when the application starts
      UrlshortenerWeb.Endpoint
      # Start a worker by calling: Urlshortener.Worker.start_link(arg)
      # {Urlshortener.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Urlshortener.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    UrlshortenerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
