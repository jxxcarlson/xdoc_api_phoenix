# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :xdoc_api,
  ecto_repos: [XdocApi.Repo]

# Configures the endpoint
config :xdoc_api, XdocApi.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "m8moHXSdlNXZ07KJCfqURjy2OlxfBqakSdBHDV2KNFxZoMUrYFmQ541y5xV8CxGq",
  render_errors: [view: XdocApi.ErrorView, accepts: ~w(html json)],
  pubsub: [name: XdocApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
