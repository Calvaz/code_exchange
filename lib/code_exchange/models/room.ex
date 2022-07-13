defmodule CodeExchange.Room do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rooms" do
		field :name, :string
		has_many :comments, CodeExchange.Comment

		timestamps()
  end

  def changeset(struct, params \\ %{}) do
		struct
		|> cast(params, [:name, :comments])
		|> validate_required([:name, :comments])
  end

end
