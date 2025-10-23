defmodule DemoElixirPhoenixWeb.PageController do
  use DemoElixirPhoenixWeb, :controller
  alias KindeClientSDK

  def index(conn, _params) do
#    grant_type = :client_credentials
    grant_type = :authorization_code

    {conn, client} =
      KindeClientSDK.init(
        conn,
        Application.get_env(:kinde_sdk, :domain) |> String.replace("\"", ""),
        Application.get_env(:kinde_sdk, :redirect_url) |> String.replace("\"", ""),
        Application.get_env(:kinde_sdk, :backend_client_id) |> String.replace("\"", ""),
        Application.get_env(:kinde_sdk, :client_secret) |> String.replace("\"", ""),
        grant_type,
        Application.get_env(:kinde_sdk, :logout_redirect_url) |> String.replace("\"", "")
      )

    conn = KindeClientSDK.login(conn, client)
    response = KindeClientSDK.get_all_data(conn)
    render(conn, "index.html", response: response)
  end

  def callback(conn, _params) do
    {conn, _client} = KindeClientSDK.get_token(conn)
    user = KindeClientSDK.get_user_detail(conn)

    if KindeClientSDK.authenticated?(conn) do
      render(conn, "callback.html", user: user)
    else
      render(conn, "index.html", user: user)
    end
  end

  def get_claims(conn, _) do
    KindeClientSDK.get_kinde_client(conn)
    {conn, _client} = KindeClientSDK.get_token(conn)
    response = KindeClientSDK.get_claim(conn, "iss")
    user = KindeClientSDK.get_user_detail(conn)
    render(conn, "callback.html", response: response, user: user)
  end

  def get_claim(conn, _) do
    KindeClientSDK.get_kinde_client(conn)
    {conn, _client} = KindeClientSDK.get_token(conn)
    response = KindeClientSDK.get_claim(conn, "iss")
    user = KindeClientSDK.get_user_detail(conn)
    render(conn, "callback.html", response: response, user: user)
  end

  # Tip: For this action to work, remember to do the PKCE login first
  def get_claim_from_id_token(conn, _) do
    KindeClientSDK.get_kinde_client(conn)
    {conn, _client} = KindeClientSDK.get_token(conn)
    response = KindeClientSDK.get_claim(conn, "iss", :id_token)
    user = KindeClientSDK.get_user_detail(conn)
    render(conn, "callback.html", response: response, user: user)
  end

  def get_claims_pkce(conn, _) do
    KindeClientSDK.get_kinde_client(conn)
    {conn, _client} = KindeClientSDK.get_token(conn)
    res1 = KindeClientSDK.get_claims(conn)
    res2 = KindeClientSDK.get_claims(conn, :id_token)
    user = KindeClientSDK.get_user_detail(conn)
    render(conn, "callback.html", response: ([res1] ++ [res2]), user: user)
  end

  def get_permissions(conn, _) do
    KindeClientSDK.get_kinde_client(conn)
    {conn, _client} = KindeClientSDK.get_token(conn)
    response = KindeClientSDK.get_permissions(conn)
    user = KindeClientSDK.get_user_detail(conn)
    render(conn, "callback.html", response: response, user: user)
  end

  def get_user(conn, _) do
    KindeClientSDK.get_kinde_client(conn)
    {conn, _client} = KindeClientSDK.get_token(conn)
    response = KindeClientSDK.get_user_detail(conn)
    user = KindeClientSDK.get_user_detail(conn)
    render(conn, "callback.html", response: response, user: user)
  end

  def get_user_organizations(conn, _) do
    KindeClientSDK.get_kinde_client(conn)
    {conn, _client} = KindeClientSDK.get_token(conn)
    response = KindeClientSDK.get_user_organizations(conn)
    user = KindeClientSDK.get_user_detail(conn)
    render(conn, "callback.html", response: response, user: user)
  end

  def log_out(conn, _params) do
    conn = KindeClientSDK.logout(conn)
    render(conn, "index.html", response: nil)
  end

  def logout(conn, _params) do
    render(conn, "index.html", response: nil)
  end

  def tokens(conn, _) do
    KindeClientSDK.get_kinde_client(conn)
    {conn, _client} = KindeClientSDK.get_token(conn)
    res = KindeClientSDK.get_all_data(conn)
    user = KindeClientSDK.get_user_detail(conn)
    render(conn, "callback.html", response: res, user: user)
  end

  def pkce_reg(conn, _) do
    grant_type = :authorization_code_flow_pkce

    {conn, client} =
      KindeClientSDK.init(
        conn,
        Application.get_env(:kinde_sdk, :domain) |> String.replace("\"", ""),
        Application.get_env(:kinde_sdk, :pkce_callback_url) |> String.replace("\"", ""),
        Application.get_env(:kinde_sdk, :frontend_client_id) |> String.replace("\"", ""),
        Application.get_env(:kinde_sdk, :client_secret) |> String.replace("\"", ""),
        grant_type,
        Application.get_env(:kinde_sdk, :pkce_logout_url) |> String.replace("\"", "")
      )

    conn = KindeClientSDK.login(conn, client)

    user = KindeClientSDK.get_user_detail(conn)

    render(conn, "callback.html", user: user)
  end

  def register(conn, _) do
    grant_type = :authorization_code_flow_pkce

    {conn, client} =
      KindeClientSDK.init(
        conn,
        Application.get_env(:kinde_sdk, :domain) |> String.replace("\"", ""),
        Application.get_env(:kinde_sdk, :pkce_callback_url) |> String.replace("\"", ""),
        Application.get_env(:kinde_sdk, :frontend_client_id) |> String.replace("\"", ""),
        Application.get_env(:kinde_sdk, :client_secret) |> String.replace("\"", ""),
        grant_type,
        Application.get_env(:kinde_sdk, :pkce_logout_url) |> String.replace("\"", "")
      )

    conn = KindeClientSDK.register(conn, client)

    res = KindeClientSDK.get_all_data(conn)
    render(conn, "callback.html", response: res)
  end

  def pkce_callack(conn, _) do
    {conn, _client} = KindeClientSDK.get_token(conn)
    user = KindeClientSDK.get_user_detail(conn)
    render(conn, "index.html", user: user)
  end

  def token_endpoint(conn, _) do
    KindeClientSDK.get_kinde_client(conn)
    {conn, _client} = KindeClientSDK.get_token(conn)
    res = KindeClientSDK.get_all_data(conn)
    user = KindeClientSDK.get_user_detail(conn)
    render(conn, "callback.html", response: res, user: user)
  end

  def start(conn, _) do
    grant_type = :authorization_code_flow_pkce

    {conn, _client} =
      KindeClientSDK.init(
        conn,
        Application.get_env(:kinde_sdk, :domain) |> String.replace("\"", ""),
        Application.get_env(:kinde_sdk, :pkce_callback_url) |> String.replace("\"", ""),
        Application.get_env(:kinde_sdk, :frontend_client_id) |> String.replace("\"", ""),
        Application.get_env(:kinde_sdk, :client_secret) |> String.replace("\"", ""),
        grant_type,
        Application.get_env(:kinde_sdk, :pkce_logout_url) |> String.replace("\"", "")
      )

    render(conn, "index.html")
  end

  def helper_methods(conn, _) do
    ## Replace the second-argument i.e. code, to what you set in feature-flags
    flag_detail1 = KindeClientSDK.get_flag(conn, "theme")
    flag_detail2 = KindeClientSDK.get_flag(conn, "is_dark_mode", "false", "s")
    render(conn, "index.html", response: [flag_detail1] ++ [flag_detail2])
  end
end
