defmodule CodeExchange.UserRoom do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_room" do
    belongs_to :user, CodeExchange.User
    belongs_to :room, CodeExchange.Room
  end

  def changeset(struct, params \\ %{}) do
		struct
		|> cast(params, [:user, :room])
		|> validate_required([:user, :room])
  end
end
