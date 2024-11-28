defmodule DemoElixirPhoenixWeb.Plugs.CheckAuth do
  import Plug.Conn
  require Logger
  alias KindeClientSDK

  def init(default), do: default

  @doc """
  Validates the authentication status by checking session tokens.

   Returns the connection, either authenticated or redirected to login.
  """
  @spec call(Plug.Conn.t(), keyword()) :: Plug.Conn.t()
  def call(conn, _opts) do
    access_token = get_session(conn, :access_token)
    refresh_token = get_session(conn, :refresh_token)

    case KindeClientSDK.get_token(conn) do
      {conn, %KindeClientSDK{} = client} ->
        authenticate(conn, client, access_token, refresh_token)
        _ ->
        redirect_to_login(conn)
    end


  end

  def authenticate(conn, client ,access_token, refresh_token) when is_binary(access_token) and is_binary(refresh_token) do
    case client do
      %{grant_type: :authorization_code_flow_pkce, auth_status: :authenticated} ->
        conn
      _ ->
        Logger.warn("Unauthorized, redirecting to login")
        redirect_to_login(conn)
    end
  end

  def authenticate(conn, client, _, _) do
    Logger.warn("Missing tokens, redirecting to login")
    redirect_to_login(conn)
  end

  defp redirect_to_login(conn) do
    conn
    |> Phoenix.Controller.redirect(to: "/log-in")
    |> halt()
  end

end
