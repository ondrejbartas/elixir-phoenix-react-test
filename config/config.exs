# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :questhor,
  ecto_repos: [Questhor.Repo]

# Configures the endpoint
config :questhor, Questhor.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "opTqK3irqU9/oAdDW5cysUL8953Cuayk1k20RfSFCcWwkh3W8ZkIzZ6gObgs79oT",
  render_errors: [view: Questhor.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Questhor.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Enable slim templates
config :phoenix, :template_engines, slim: PhoenixSlime.Engine
