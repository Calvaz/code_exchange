defmodule CodeExchange.Repo do
  use Ecto.Repo,
    otp_app: :code_exchange,
    adapter: Ecto.Adapters.Postgres
end
