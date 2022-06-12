defmodule CodeExchangeWeb.CounterLive do
  use CodeExchangeWeb, :live_view

  def mount(_params, _session, socket) do

    socket = assign(socket, count: 0)
    {:ok, socket}
  end

  def handle_event("increase", _, socket) do
    # Add 1 to the current count
    socket = assign(socket, count: socket.assigns.count + 1)
    {:noreply, socket}
  end
end
