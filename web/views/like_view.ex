defmodule Questhor.LikeView do
  use Questhor.Web, :view

  def render("index.json", %{likes: likes}) do
    %{data: render_many(likes, Questhor.LikeView, "like.json")}
  end

  def render("show.json", %{like: like}) do
    %{data: render_one(like, Questhor.LikeView, "like.json")}
  end

  def render("like.json", %{like: like}) do
    %{id: like.id,
      user_id: like.user_id,
      question_id: like.question_id}
  end
end
