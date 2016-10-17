defmodule Questhor.UserView do
  use Questhor.Web, :view

  def render("show.json", %{user: user}) do
    %{data: render_one(user, Questhor.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      name: user.name}
  end
end
