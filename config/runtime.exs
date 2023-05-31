import Config

import Envar

# will load .env file to load environment variables
Envar.load(".env")

# configure kinde_sdk on runtime
config :kinde_sdk,
  backend_client_id: Envar.get("KINDE_BACKEND_CLIENT_ID"),
  frontend_client_id: Envar.get("KINDE_FRONTEND_CLIENT_ID"),
  client_secret: Envar.get("KINDE_CLIENT_SECRET"),
  redirect_url: Envar.get("KINDE_REDIRECT_URL"),
  domain: Envar.get("KINDE_DOMAIN"),
  logout_redirect_url: Envar.get("KINDE_LOGOUT_REDIRECT_URL"),
  pkce_logout_url: Envar.get("KINDE_PKCE_LOGOUT_URL"),
  pkce_callback_url: Envar.get("KINDE_PKCE_REDIRECT_URL")
