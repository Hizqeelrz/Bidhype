# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :bidhype,
  ecto_repos: [Bidhype.Repo]

# Configures the endpoint
config :bidhype, BidhypeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "miLjVPFZITt9qzlb9hm55kFp9UN21kokLkFcSlu6RRQGkPPY4IxiC4cSP2bowkgj",
  render_errors: [view: BidhypeWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Bidhype.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [
    signing_salt: "UVt0g4MQPItfvE+bP98DLjS8Cr5s3otB"
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :arc,
version_timeout: 300_000,
storage: Arc.Storage.Local
# bucket: "xolo-dev"

case Mix.env() do
  :dev ->
    config :bidhype,
      img_host: "http://192.168.10.13:4000"
end

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
