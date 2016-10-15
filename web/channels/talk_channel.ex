defmodule Questhor.TalkChannel do
  use Phoenix.Channel

  def join("talk:lobby", _message, socket) do
    {:ok, socket}
  end

  def join("talk:" <> _talk_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end
end
