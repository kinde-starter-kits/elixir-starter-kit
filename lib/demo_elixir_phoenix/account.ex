defmodule DemoElixirPhoenix.Account do
  @moduledoc """
  The Account context.
  """

  import Ecto.Query, warn: false
  alias DemoElixirPhoenix.Repo

  alias DemoElixirPhoenix.Account.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  alias KindeClientSdk

  def kinde_go() do
    domain = "https://elixirsdk.kinde.com"
    redirect_url = "http://localhost:4000/callback"
    client_id = "48e3345e636c4e33a2fd44413d252138"
    client_secret = "dPEIzTGS8TNGPiH0HXOXuF9f7p8Pm6zV4VOjgZsFkiR5muN9m"
    grant_type = :client_credentials
    logout_redirect_url = "http://localhost:4000/logout"

    client =
      KindeClientSdk.init(
        domain,
        redirect_url,
        client_id,
        client_secret,
        grant_type,
        logout_redirect_url
      )

    KindeClientSdk.login()
  end
end
