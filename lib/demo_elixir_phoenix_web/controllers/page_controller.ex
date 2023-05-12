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

    conn = KindeClientSDK.login(conn, client)

    response = KindeClientSDK.get_all_data(conn)

    render(conn, "index.html", response: response.token)
  end

  def callback(conn, _params) do
    KindeClientSDK.get_kinde_client(conn)

    {conn, client} = KindeClientSDK.get_token(conn)

    render(conn, "index.html", response: nil)
  end

  def get_claims(conn, _) do
    response = KindeClientSDK.get_claims(conn)
    render(conn, "index.html", response: response)
  end

  def get_claim(conn, _) do
    ## you can change the "iss" to any other claim-object-key
    response = KindeClientSDK.get_claim(conn, "iss")
    render(conn, "index.html", response: response)
  end

  # Tip: For this action to work, remember to do the PKCE login first
  def get_claim_from_id_token(conn, _) do
    ## you can change the "iss" to any other claim-object-key
    response = KindeClientSDK.get_claim(conn, "iss", :id_token)
    render(conn, "index.html", response: response)
  end

  def get_claims_pkce(conn, _) do
    res1 = KindeClientSDK.get_claims(conn)
    res2 = KindeClientSDK.get_claims(conn, :id_token)
    render(conn, "index.html", response: [res1] ++ [res2])
  end

  def get_permissions(conn, _) do
    response = KindeClientSDK.get_permissions(conn)
    render(conn, "index.html", response: response)
  end

  def get_user(conn, _) do
    response = KindeClientSDK.get_user_detail(conn)
    render(conn, "index.html", response: response)
  end

  def get_user_organizations(conn, _) do
    response = KindeClientSDK.get_user_organizations(conn)

    render(conn, "index.html", response: response)
  end

  def log_out(conn, _params) do
    conn = KindeClientSDK.logout(conn)

    render(conn, "index.html", response: nil)
  end

  def logout(conn, _params) do
    render(conn, "index.html", response: nil)
  end

  def tokens(conn, _) do
    res = KindeClientSDK.get_all_data(conn)
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

    conn = KindeClientSDK.login(conn, client)

    res = KindeClientSDK.get_all_data(conn)

    render(conn, "index.html", response: nil)
  end

  def pkce_callack(conn, _) do
    {conn, client} = KindeClientSDK.get_token(conn)
    res = KindeClientSDK.get_all_data(conn)
    render(conn, "index.html", response: res)
  end

  def start(conn, _) do
    render(conn, "index.html", response: nil)
  end
end
