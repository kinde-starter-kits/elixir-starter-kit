import Config

import Envar

# will load .env file to load environment variables
Envar.load(".env")

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