defmodule CodeExchange.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    IO.puts("Starting ....")

    children = [
      # Start the Ecto repository
      CodeExchange.Repo,
      # Start the Telemetry supervisor
      CodeExchangeWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: CodeExchange.PubSub},
      # Start the Endpoint (http/https)
      CodeExchangeWeb.Endpoint
      # Start a worker by calling: CodeExchange.Worker.start_link(arg)
      # {CodeExchange.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CodeExchange.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CodeExchangeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
