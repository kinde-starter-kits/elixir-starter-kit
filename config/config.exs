# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :demo_elixir_phoenix,
  ecto_repos: [DemoElixirPhoenix.Repo]

# Configures the endpoint
config :demo_elixir_phoenix, DemoElixirPhoenixWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "OBbWwZBYwAD1CLXZsuiKY1buqf/edpwT8VfL7ZAw+1UD8jGqOGH9vdJktYaBEMyX",
  render_errors: [view: DemoElixirPhoenixWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: DemoElixirPhoenix.PubSub,
  live_view: [signing_salt: "DWxOrTvj"]

# Kinde SDK
config :kinde_sdk,
  backend_client_id: System.get_env("KINDE_BACKEND_CLIENT_ID"),
  frontend_client_id: System.get_env("KINDE_FRONTEND_CLIENT_ID"),
  client_secret: System.get_env("KINDE_CLIENT_SECRET"),
  redirect_url: System.get_env("KINDE_REDIRECT_URL"),
  domain: System.get_env("KINDE_DOMAIN"),
  logout_redirect_url: System.get_env("KINDE_LOGOUT_REDIRECT_URL"),
  pkce_logout_url: System.get_env("KINDE_PKCE_LOGOUT_URL"),
  pkce_callback_url: System.get_env("KINDE_PKCE_REDIRECT_URL")

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
