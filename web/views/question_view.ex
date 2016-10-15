defmodule Questhor.QuestionView do
  use Questhor.Web, :view

  alias Questhor.Repo
  alias Questhor.Talk

  def talks do
    Repo.all(Talk)
  end
end
