defmodule DemoElixirPhoenixWeb.PageController do
  use DemoElixirPhoenixWeb, :controller
  alias KindeClientSDK

  def index(conn, _params) do
    grant_type = :client_credentials

    {conn, client} =
      KindeClientSDK.init(
        conn,
        Application.get_env(:kinde_sdk, :domain),
        Application.get_env(:kinde_sdk, :redirect_url),
        Application.get_env(:kinde_sdk, :backend_client_id),
        Application.get_env(:kinde_sdk, :client_secret),
        grant_type,
        Application.get_env(:kinde_sdk, :logout_redirect_url)
      )

    IO.inspect(client, label: "Client after creation ====>")

    conn = KindeClientSDK.login(conn, client)

    response = KindeClientSDK.get_all_data(conn)
    IO.inspect(response.token, label: "kinde_token")

    render(conn, "index.html", response: response.token)
  end

  def callback(conn, _params) do
    KindeClientSDK.get_kinde_client(conn)
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

  def get_claim(conn, _) do
    KindeClientSDK.authenticated?(conn) |> IO.inspect(label: "authenticated?")
    response = KindeClientSDK.get_claim(conn, "iss") |> IO.inspect(label: "claim object from access_token") ## you can change the "iss" to any other claim-object-key
    render(conn, "index.html", response: response)
  end

  # Tip: For this action to work, remember to do the PKCE login first
  def get_claim_from_id_token(conn, _) do
    KindeClientSDK.authenticated?(conn) |> IO.inspect(label: "authenticated?")
    response = KindeClientSDK.get_claim(conn, "iss", :id_token) |> IO.inspect(label: "claim object from id_token") ## you can change the "iss" to any other claim-object-key
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
    KindeClientSDK.get_kinde_client(conn)
    |> IO.inspect(label: "kinde_client AFTER LOGOUT")

    render(conn, "index.html", response: nil)
  end

  def tokens(conn, _) do
    res = KindeClientSDK.get_all_data(conn)

    IO.inspect(res.login_time_stamp, label: "kinde_login_time_stamp")
    IO.inspect(res.access_token, label: "kinde_access_token")
    IO.inspect(res.id_token, label: "kinde_id_token")
    IO.inspect(res.expires_in, label: "kinde_expires_in")
    IO.inspect(res.token, label: "kinde_token")
    IO.inspect(res.user, label: "kinde_user")

    render(conn, "index.html", response: res)
  end

  def pkce_reg(conn, _) do
    grant_type = :authorization_code_flow_pkce

    {conn, client} =
      KindeClientSDK.init(
        conn,
        Application.get_env(:kinde_sdk, :domain),
        Application.get_env(:kinde_sdk, :pkce_callback_url),
        Application.get_env(:kinde_sdk, :frontend_client_id),
        Application.get_env(:kinde_sdk, :client_secret),
        grant_type,
        Application.get_env(:kinde_sdk, :pkce_logout_url)
      )

    IO.inspect(client, label: "Client after creation ====>")

    conn = KindeClientSDK.login(conn, client)

    res = KindeClientSDK.get_all_data(conn)
    IO.inspect(res.oauth_code_verifier, label: "kinde_oauth_code_verifier BEFORE")

    render(conn, "index.html", response: nil)
  end

  def pkce_callack(conn, _) do
    IO.inspect(conn, label: "pkce_callback")

    KindeClientSDK.get_kinde_client(conn)
    |> IO.inspect(label: "kinde_client BEFORE")

    {conn, client} = KindeClientSDK.get_token(conn)

    IO.inspect(client, label: "kinde_client AFTER")

    res = KindeClientSDK.get_all_data(conn)

    IO.inspect(res.login_time_stamp, label: "kinde_login_time_stamp")
    IO.inspect(res.access_token, label: "kinde_access_token")
    IO.inspect(res.id_token, label: "kinde_id_token")
    IO.inspect(res.expires_in, label: "kinde_expires_in")
    IO.inspect(res.token, label: "kinde_token")
    IO.inspect(res.user, label: "kinde_user")

    render(conn, "index.html", response: res)
  end

  def start(conn, _) do
    render(conn, "index.html", response: nil)
  end
end
