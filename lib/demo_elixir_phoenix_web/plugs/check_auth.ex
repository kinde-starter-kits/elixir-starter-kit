defmodule DemoElixirPhoenixWeb.Plugs.CheckAuth do
  import Plug.Conn
  alias KindeClientSDK

  def init(default), do: default

  def call(conn, _opts) do
    access_token = get_session(conn, :access_token)
    refresh_token = get_session(conn, :refresh_token)

    if access_token && refresh_token do
      conn = KindeClientSDK.init_with_tokens(conn, access_token, refresh_token)
      conn
    else
      conn
      |> Phoenix.Controller.redirect(to: "/log-in")
      |> halt()
    end
  end
end
