defmodule CodeExchange.Repo.Migrations.UpdateUserTimestamp do
  use Ecto.Migration

  def change do
    alter table(:users) do
      timestamps null: false
    end
  end
end
