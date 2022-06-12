defmodule CodeExchangeWeb.HomeController do
  use CodeExchangeWeb, :controller

  def index(conn, _params) do
    render(conn, "./templates/page/index.html")
  end
end
