defmodule DemoElixirPhoenixWeb.NotFoundController do
  use DemoElixirPhoenixWeb, :controller

  def not_found(conn, _params) do
    conn
    |> put_status(:not_found)
    |> redirect(to: "/")
  end
end
