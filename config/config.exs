# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :quad, QuadWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "sAlyIaQcpYfXS8XMCjMW1wat92NBj57/W8H0ctYy8DzvWT4UZpVDP2rICqSyf7TN",
  render_errors: [view: QuadWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Quad.PubSub, adapter: Phoenix.PubSub.PG2], 
  live_view: [
     signing_salt: "RNNhslNeLkpcp+Z5zMPHzo6C8agWRooH"
   ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
