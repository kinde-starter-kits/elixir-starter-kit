defmodule DemoElixirPhoenixWeb.Router do
  use DemoElixirPhoenixWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end


  pipeline :authenticated do
    plug DemoElixirPhoenixWeb.Plugs.CheckAuth
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", DemoElixirPhoenixWeb do
    pipe_through([:browser, :authenticated])

    get("/", PageController, :start)
    get("/callback", PageController, :callback)
    get("/log-out", PageController, :log_out)
    get("/logout", PageController, :logout)
    get("/claims", PageController, :get_claims)
    get("/get_claim", PageController, :get_claim)
    get("/get_claim_from_id_token", PageController, :get_claim_from_id_token)
    get("/claims-pkce", PageController, :get_claims_pkce)
    get("/permissions", PageController, :get_permissions)
    get("/user", PageController, :get_user)
    get("/organization", PageController, :get_user_organizations)
    get("/token", PageController, :tokens)
    get("/helper_methods", PageController, :helper_methods)
  end

   scope "/", DemoElixirPhoenixWeb do
    pipe_through(:browser)

    get("/log-in", PageController, :index)
    get("/pkce-reg", PageController, :pkce_reg)
    get("/pkce-callback", PageController, :pkce_callack)
    get("/token-endpoint", PageController, :token_endpoint)
  end

  # Other scopes may use custom stacks.
  # scope "/api", DemoElixirPhoenixWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through(:browser)
    end
  end
end
