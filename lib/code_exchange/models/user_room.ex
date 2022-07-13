defmodule CodeExchange.UserRooms do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_rooms" do
    belongs_to :user, CodeExchange.User
    belongs_to :room, CodeExchange.Room
  end

  def changeset(struct, params \\ %{}) do
		struct
		|> cast(params, [:user, :room])
		|> validate_required([:user, :room])
  end
end
