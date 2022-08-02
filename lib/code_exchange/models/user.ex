defmodule CodeExchange.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
		field :email, :string
		field :provider, :string
		field :token, :string
		#has_many :rooms, CodeExchange.Room
		#has_many :comments, CodeExchange.Comments

		timestamps()
  end

  def changeset(struct, params \\ %{}) do
		struct
		|> cast(params, [:email, :provider, :token])
		|> validate_required([:email, :provider, :token])
  end
end
