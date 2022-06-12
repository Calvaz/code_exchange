import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :code_exchange, CodeExchange.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "code_exchange_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :code_exchange, CodeExchangeWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "bsm66rHq2B0B03yG4Eyrxc+Ih5/vAQgecaRa+Cau2TG3q7RlKhig0YjPokx8JXbD",
  server: false

# In test we don't send emails.
config :code_exchange, CodeExchange.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
