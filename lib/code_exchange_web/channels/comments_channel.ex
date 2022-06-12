defmodule CodeExchange.CommentsChannel do
	use CodeExchangeWeb, :channel
	alias CodeExchange.{Room, Comment}

	def join("comments:" <> room_id, _params, socket) do
		room_id = String.to_integer(room_id)
		room = Room
			|> Repo.get(Room, room_id)
			|> Repo.preload(:comments)

		{:ok, %{comments: room.comments}, assign(socket, :room, room)}
	end

	def handle_in(name, %{content: content}, socket) do
		room = socket.assigns.room_id
		user_id = socket.assigns.user_id

		changeset = room
			|> Ecto.build_assoc(:comments, user_id: user_id)
			|> Comment.changeset(%{content: content})

		case Repo.insert(changeset) do
			{:ok, comment} ->
				CodeExchangeWeb.CodeController.broadcast!{socket, "comments:#{socket.assigns.room.id}:new", %{comment: comment}}
				{:reply, :ok, socket}
			{:error, _reason} ->
				{:reply, {:error, %{errors: changeset}}, socket}

		end

		{:reply, :ok, socket}
	end
end
