defmodule CodeExchange.GithubAPI do

  require Logger
  use Tesla
  plug Tesla.Middleware.BaseUrl, "https://api.github.com"

  def get_auth_user(token) do
    tesla_client(token)
    |> tesla_get("/user/emails")
  end

  def get_repos(owner, repo \\ "") do
    #{:ok, response} = tesla_get("/repos/" <> owner <> "/" <> repo)
    #response
  end

  def tesla_client(token) do
    middleware = [
      {Tesla.Middleware.BaseUrl, "https://api.github.com"},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.BearerAuth, token: token}]

    Tesla.client(middleware)
  end

  def tesla_get(client, params) do
    response = Tesla.get(client, params)

    if Application.get_env(:tesla, :debug) do
      Logger.debug("""
        Tesla Request #{params}

        Response:
        #{inspect(response)}
      """)
    end

    response
  end
end
