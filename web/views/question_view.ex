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
    %{id: question.id,
      text: question.text,
      likes: question.likes}
  end
end
