defmodule CodeExchange.Services.GithubAPI do

  require Logger
  alias CodeExchange.Helpers.Tesla
  alias CodeExchange.Repo
  alias CodeExchange.User

  @github_api_baseurl "https://api.github.com"

  def get_user_emails(access_token) do
    get(access_token, "/user/emails")
  end

  def get_repos(user_id) do
    get_token(user_id)
    |> get("/repositories")
  end

  def get_user(access_token) do
    get(access_token, "/user")
  end

  defp get(access_token, endpoint) do
    Tesla.client(access_token, @github_api_baseurl)
    |> Tesla.get(endpoint)
  end

  defp get_token(user_id) do
    %{:token => access_token} = Repo.get_by(User, id: user_id)
    access_token
  end

end
