# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :urlshortener,
  ecto_repos: [Urlshortener.Repo]

# Configures the endpoint
config :urlshortener, UrlshortenerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "nyVyEtpU8kISXsT6SONrNYOGuDitF9L2+DOEnHY9BbH4orxDdvuArW7PWZZ158vD",
  render_errors: [view: UrlshortenerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Urlshortener.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
