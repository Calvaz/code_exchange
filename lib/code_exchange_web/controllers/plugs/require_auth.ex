defmodule CodeExchange.Plugs.RequireAuth do
  import Plug.Conn
  import Phoenix.Controller

  def init() do
  end

  def call(conn, _params) do
    if conn.assigns[:user] do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in.")
      |> redirect(to: Routes.live_path(conn, CodeExchangeWeb.HomeLive))
      |> halt()
    end
  end
end
