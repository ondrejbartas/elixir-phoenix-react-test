defmodule Questhor.QuestionView do
  use Questhor.Web, :view

  alias Questhor.Repo
  alias Questhor.Talk

  def talks do
    Repo.all(Talk)
  end

  def render("index.json", %{questions: questions}) do
    %{data: render_many(questions, Questhor.QuestionView, "question.json")}
  end

  def render("show.json", %{question: question}) do
    %{data: render_one(question, Questhor.QuestionView, "question.json")}
  end

  def render("question.json", %{question: question}) do
    user_ids = Questhor.Repo.preload(question, [likes: :user]).likes
      |> Enum.sort(&(&1.inserted_at > &2.inserted_at))
      |> Enum.map(&(%{id: &1.id, user_id: &1.user_id, user_name: &1.user.name}))
      |> Enum.uniq(&(&1.user_id))

    %{
      id: question.id,
      talk_id: question.talk_id,
      text: question.text,
      # likesCount: (Ecto.Model.assoc(question, :likes) |> Repo.aggregate(:count, :id)),
      likesCount: length(user_ids),
      likes: user_ids
    }
  end
end
