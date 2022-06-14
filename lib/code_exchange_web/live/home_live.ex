defmodule CodeExchangeWeb.HomeLive do
  use CodeExchangeWeb, :live_view

  def mount(_, _, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    CodeExchangeWeb.HomeView.render("index.html", assigns)
  end
end
