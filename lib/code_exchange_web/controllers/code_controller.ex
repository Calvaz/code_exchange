defmodule CodeExchangeWeb.CodeController do
  use CodeExchangeWeb, :controller

  def index(conn, __params) do
    render(conn, "index.html", layout: {CodeExchangeWeb.LayoutView, "root.html"})
  end
end
