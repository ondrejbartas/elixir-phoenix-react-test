defmodule Questhor.TalkView do
  use Questhor.Web, :view

  def render("index.json", %{talks: talks}) do
    %{data: render_many(talks, Questhor.TalkView, "talk.json")}
  end

  def render("show.json", %{talk: talk}) do
    %{data: render_one(talk, Questhor.TalkView, "talk.json")}
  end

  def render("talk.json", %{talk: talk}) do
    %{id: talk.id,
      name: talk.name,
      questions: render_many(talk.questions, Questhor.QuestionView, "question.json")}
  end
end
