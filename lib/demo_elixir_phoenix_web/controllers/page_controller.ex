defmodule DemoElixirPhoenixWeb.PageController do
  use DemoElixirPhoenixWeb, :controller
  alias KindeClientSDK
  alias Plug.Conn

  def index(conn, _params) do
    grant_type = :client_credentials

    {conn, client} =
      KindeClientSDK.init(
        conn,
        Application.get_env(:kinde_management_api, :domain),
        Application.get_env(:kinde_management_api, :redirect_url),
        Application.get_env(:kinde_management_api, :backend_client_id),
        Application.get_env(:kinde_management_api, :client_secret),
        grant_type,
        Application.get_env(:kinde_management_api, :logout_redirect_url)
      )

    IO.inspect(client, label: "Client after creation ====>")

    conn = KindeClientSDK.login(conn, client)

    pid = Conn.get_session(conn, :kinde_cache_pid)
    # IO.inspect(conn, label: "conn")

    [kinde_token: response] =
      GenServer.call(pid, {:get_kinde_data, :kinde_token})
      |> IO.inspect(label: "kinde_token")

    render(conn, "index.html", response: response)
  end

  def callback(conn, _params) do
    pid = Conn.get_session(conn, :kinde_cache_pid)

    GenServer.call(pid, {:get_kinde_data, :kinde_client})
    |> IO.inspect(label: "kinde_client BEFORE")

    {conn, client} = KindeClientSDK.get_token(conn)

    IO.inspect(client, label: "kinde_client AFTER")

    render(conn, "index.html", response: nil)
  end

  def get_claims(conn, _) do
    KindeClientSDK.authenticated?(conn) |> IO.inspect(label: "authenticated?")
    response = KindeClientSDK.get_claims(conn) |> IO.inspect(label: "claims from access_token")
    render(conn, "index.html", response: response)
  end

  def get_claims_pkce(conn, _) do
    KindeClientSDK.authenticated?(conn) |> IO.inspect(label: "authenticated?")
    res1 = KindeClientSDK.get_claims(conn) |> IO.inspect(label: "claims from access_token")
    res2 = KindeClientSDK.get_claims(conn, :id_token) |> IO.inspect(label: "claims from id_token")
    render(conn, "index.html", response: [res1] ++ [res2])
  end

  def get_permissions(conn, _) do
    response = KindeClientSDK.get_permissions(conn) |> IO.inspect(label: "permissions")
    render(conn, "index.html", response: response)
  end

  def get_user(conn, _) do
    response = KindeClientSDK.get_user_detail(conn) |> IO.inspect(label: "user")
    render(conn, "index.html", response: response)
  end

  def get_user_organizations(conn, _) do
    response =
      KindeClientSDK.get_user_organizations(conn) |> IO.inspect(label: "user_organizations")

    render(conn, "index.html", response: response)
  end

  def log_out(conn, _params) do
    conn = KindeClientSDK.logout(conn)

    render(conn, "index.html", response: nil)
  end

  def logout(conn, _params) do
    pid = Conn.get_session(conn, :kinde_cache_pid)

    GenServer.call(pid, {:get_kinde_data, :kinde_client})
    |> IO.inspect(label: "kinde_client AFTER LOGOUT")

    render(conn, "index.html", response: nil)
  end

  def tokens(conn, _) do
    pid = Conn.get_session(conn, :kinde_cache_pid)

    res1 =
      GenServer.call(pid, {:get_kinde_data, :kinde_login_time_stamp})
      |> IO.inspect(label: "kinde_login_time_stamp")

    res2 =
      GenServer.call(pid, {:get_kinde_data, :kinde_access_token})
      |> IO.inspect(label: "kinde_access_token")

    res3 =
      GenServer.call(pid, {:get_kinde_data, :kinde_id_token})
      |> IO.inspect(label: "kinde_id_token")

    res4 =
      GenServer.call(pid, {:get_kinde_data, :kinde_expires_in})
      |> IO.inspect(label: "kinde_expires_in")

    res5 =
      GenServer.call(pid, {:get_kinde_data, :kinde_token}) |> IO.inspect(label: "kinde_token")

    res6 = GenServer.call(pid, {:get_kinde_data, :kinde_user}) |> IO.inspect(label: "kinde_user")
    render(conn, "index.html", response: {res1, res2, res3, res4, res5, res6})
  end

  def pkce_reg(conn, _) do
    grant_type = :authorization_code_flow_pkce

    {conn, client} =
      KindeClientSDK.init(
        conn,
        Application.get_env(:kinde_management_api, :domain),
        Application.get_env(:kinde_management_api, :pkce_callback_url),
        Application.get_env(:kinde_management_api, :frontend_client_id),
        Application.get_env(:kinde_management_api, :client_secret),
        grant_type,
        Application.get_env(:kinde_management_api, :pkce_logout_url)
      )

    IO.inspect(client, label: "Client after creation ====>")

    conn = KindeClientSDK.login(conn, client)

    pid = Conn.get_session(conn, :kinde_cache_pid)

    GenServer.call(pid, {:get_kinde_data, :kinde_oauth_code_verifier})
    |> IO.inspect(label: "kinde_oauth_code_verifier BEFORE")

    render(conn, "index.html", response: nil)
  end

  def pkce_callack(conn, _) do
    IO.inspect(conn, label: "pkce_callback")

    pid = Conn.get_session(conn, :kinde_cache_pid)

    GenServer.call(pid, {:get_kinde_data, :kinde_client})
    |> IO.inspect(label: "kinde_client BEFORE")

    {conn, client} = KindeClientSDK.get_token(conn)

    IO.inspect(client, label: "kinde_client AFTER")

    res1 =
      GenServer.call(pid, {:get_kinde_data, :kinde_login_time_stamp})
      |> IO.inspect(label: "kinde_login_time_stamp")

    res2 =
      GenServer.call(pid, {:get_kinde_data, :kinde_access_token})
      |> IO.inspect(label: "kinde_access_token")

    res3 =
      GenServer.call(pid, {:get_kinde_data, :kinde_id_token})
      |> IO.inspect(label: "kinde_id_token")

    res4 =
      GenServer.call(pid, {:get_kinde_data, :kinde_expires_in})
      |> IO.inspect(label: "kinde_expires_in")

    res5 =
      GenServer.call(pid, {:get_kinde_data, :kinde_token}) |> IO.inspect(label: "kinde_token")

    res6 = GenServer.call(pid, {:get_kinde_data, :kinde_user}) |> IO.inspect(label: "kinde_user")

    render(conn, "index.html", response: {res1, res2, res3, res4, res5, res6})
  end

  def start(conn, _) do
    render(conn, "index.html", response: nil)
  end
end
