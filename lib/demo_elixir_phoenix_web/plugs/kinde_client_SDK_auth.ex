defmodule DemoElixirPhoenixWeb.Plugs.KindeClientSDKAuth do
  use DemoElixirPhoenixWeb, :controller

  def init(options), do: options

  def call(conn, _opts) do
    if KindeClientSDK.authenticated?(conn) do
      conn
    else
      Plug.Conn.halt(conn)
      |> Plug.Conn.put_status(403)
      |> put_view(DemoElixirPhoenixWeb.PageView)
      |> render("index.html", response: nil)
    end
  end
end
