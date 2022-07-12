defmodule CodeExchange.Github do
  @moduledoc """
  An OAuth2 strategy for GitHub.
  """
  use OAuth2.Strategy

  alias OAuth2.Strategy.AuthCode
  alias CodeExchange.GithubAPI

  @github_env Application.get_env(:oauth2, Github)
  @github_scopes "user,repo,repo_deployment,repo:invite,notifications,project,write:discussion,read:discussion"

  defp config do
    [strategy: __MODULE__,
      site: "https://api.github.com",
      authorize_url: "https://github.com/login/oauth/authorize",
      token_url: "https://github.com/login/oauth/access_token"]
  end

  # Public API

  def client do
    @github_env
    |> Keyword.merge(config())
    |> OAuth2.Client.new()
  end

  def authorize_url! do
    OAuth2.Client.authorize_url!(client(), scope: @github_scopes)
  end

  def get_token!(params \\ [], headers \\ [], opts \\ []) do
    OAuth2.Client.get_token!(client(), params, headers, opts)
  end

  # Strategy Callbacks

  def authorize_url(client, params) do
    AuthCode.authorize_url(client, params)
  end

  def get_token(client, params, headers) do
    client
    |> put_header("Accept", "application/json")
    |> AuthCode.get_token(params, headers)
  end

  def get_user_email(%OAuth2.Client{:token => %OAuth2.AccessToken{:access_token => token}}) do
    %{"access_token" => access_token} = Jason.decode!(~s(#{token}))
    GithubAPI.get_auth_user(access_token)
  end

end
