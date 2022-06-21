defmodule CodeExchange.Github do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://api.github.com"

  def get_repos(owner, repo \\ "") do
    {:ok, response} = get("/repos/" <> owner <> "/" <> repo)
    response
  end

end
