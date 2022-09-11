defmodule CodeExchange.Helpers.Tesla do

  require Logger
  use Tesla

  def client(token, url) do
    middleware = [
      {Tesla.Middleware.BaseUrl, url},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.BearerAuth, token: token}]

    Tesla.client(middleware)
  end

  def get(client, params) do
    response = Tesla.get(client, params)

    if Application.get_env(:tesla, :debug) do
      Logger.debug("""
        Tesla Request #{params}

        Response:
        #{inspect(response)}
      """)
    end

    response
  end
end
