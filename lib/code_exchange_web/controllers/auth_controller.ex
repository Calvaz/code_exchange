defmodule CodeExchangeWeb.AuthController do
  use CodeExchangeWeb, :controller

  alias CodeExchange.User
  alias CodeExchange.Github
  alias CodeExchange.Repo

  def request(conn, _provider) do
    redirect conn, external: authorize_url!()
  end

  def callback(conn, %{"error_description" => error_description}) do
    conn
    |> put_flash(:error, "Failed to authenticate because #{error_description}")
    |> redirect(to: Routes.live_path(conn, CodeExchangeWeb.HomeLive))
  end

  def callback(conn, %{"provider" => _provider, "code" => code}) do
    client = get_token!(code)

    # Request the user's data with the access token
    case Github.get_user_email(client) do
      {:ok, response} ->
        for email <- response.body, email["primary"] == true do
          changeset = User.changeset(%User{}, %{email: email, token: client, provider: "github"})
          signin(conn, changeset)
        end
      {:error, error} ->
        error
    end
  end

  def callback(conn, %{"error_description" => error_description}) do
    conn
    |> put_flash(:info, "An error occurred: #{error_description}")
    |> redirect(to: Routes.live_path(conn, CodeExchangeWeb.HomeLive))
  end

  defp upsert_user(changeset) do
    case Repo.get_by(User, email: changeset.changes.email) do
      nil ->
        Repo.insert(changeset)
      user ->
        {:ok, user}
    end
  end

  defp signin(conn, changeset) do
    case upsert_user(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome back")
        |> put_session(:user_id, user.id)
        |> configure_session(renew: true)
        |> redirect(to: Routes.live_path(conn, CodeExchangeWeb.HomeLive))
      {:error, _reason} ->
        conn
        |> put_flash(:error, "Error signing in")
        |> redirect(to: Routes.live_path(conn, CodeExchangeWeb.HomeLive))
    end
  end

  def signout(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: Routes.live_path(conn, CodeExchangeWeb.HomeLive))
  end

  defp authorize_url!(),   do: Github.authorize_url!
  defp get_token!(code),   do: Github.get_token!(code: code)
  defp get_user!(client) do
    %{body: user} = OAuth2.Client.get!(client, "/user")
    %{name: user["name"], avatar: user["avatar_url"]}
  end
end
