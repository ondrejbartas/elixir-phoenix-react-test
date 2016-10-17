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
    payload = %{
      "type" => "UPDATE_QUESTION",
      "payload" => %{
        "id" => question.id,
        "talk_id" => question.talk_id,
        "text" => question.text,
        "likes" => question.likes
      }
    }
    Questhor.Endpoint.broadcast("question:lobby", "change", payload)
  end
end
