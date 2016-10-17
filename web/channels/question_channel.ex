defmodule Questhor.QuestionChannel do
  use Questhor.Web, :channel

  def join("question:lobby", _, socket) do
    {:ok, socket}
  end

  def join("question:" <> question_id, _, socket) do
    {:ok, "Joined question:#{question_id}", socket}
  end


  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_out(event, payload, socket) do
    push socket, event, payload
    {:noreply, socket}
  end

  def broadcast_change(question) do
    user_ids = Questhor.Repo.preload(question, [likes: :user]).likes
      |> Enum.sort(&(&1.inserted_at > &2.inserted_at))
      |> Enum.map(&(%{id: &1.id, user_id: &1.user_id, user_name: &1.user.name}))
      |> Enum.uniq(&(&1.user_id))

    payload = %{
      "type" => "UPDATE_QUESTION",
      "payload" => %{
        "id" => question.id,
        "talk_id" => question.talk_id,
        "text" => question.text,
        "likesCount" => length(user_ids),
        "likes" => user_ids
      }
    }
    Questhor.Endpoint.broadcast("question:lobby", "change", payload)
  end
end
