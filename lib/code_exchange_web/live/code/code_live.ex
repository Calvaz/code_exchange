defmodule CodeExchangeWeb.CodeLive do
  use CodeExchangeWeb, :live_view
  import CodeExchange.GithubAPI

  def mount(_, _, socket) do
    github_pr = get_repos("user_id")
    {:ok, assign(socket, :github_pr, github_pr)}
  end

end
