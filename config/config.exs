# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :miotwo, MiotwoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "N5lt0cU5vlpOo39PkMErjr02rRJPg5y1sMjA2iBj4KHeo7k4mtfJ86JtLnPET+hZ",
  render_errors: [view: MiotwoWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Miotwo.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :miotwo,
  marta_train_api_key: "${MARTA_TRAIN_API_KEY}"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
