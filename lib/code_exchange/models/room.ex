defmodule CodeExchange.Room do
  use Ecto.Schema
  import Ecto.Changeset

  schema "room" do
		field :name, :string
		has_many :comments, CodeExchange.Comments

		timestamps()
  end

  def changeset(struct, params \\ %{}) do
		struct
		|> cast(params, [:name, :comments])
		|> validate_required([:name, :comments])
  end

end
