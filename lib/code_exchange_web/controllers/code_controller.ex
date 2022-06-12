defmodule CodeExchangeWeb.CodeController do
  use CodeExchangeWeb, :controller

  def index(conn, _params) do
    render(conn, "code.html")
  end
end
