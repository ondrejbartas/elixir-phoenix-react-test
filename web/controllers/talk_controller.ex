defmodule Questhor.TalkController do
  use Questhor.Web, :controller

  plug :action

  alias Questhor.Talk

  def index(conn, _params) do
    talks = Repo.all(Talk) |> Repo.preload([questions: :likes])
    render(conn, :index, talks: talks)
  end

  def new(conn, _params) do
    changeset = Talk.changeset(%Talk{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"talk" => talk_params}) do
    changeset = Talk.changeset(%Talk{}, talk_params)

    case Repo.insert(changeset) do
      {:ok, _talk} ->
        conn
        |> put_flash(:info, "Talk created successfully.")
        |> redirect(to: talk_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    talk = Repo.get!(Talk, id) |> Repo.preload([questions: :likes])
    render(conn, :show, talk: talk)
  end

  def edit(conn, %{"id" => id}) do
    talk = Repo.get!(Talk, id)
    changeset = Talk.changeset(talk)
    render(conn, "edit.html", talk: talk, changeset: changeset)
  end

  def update(conn, %{"id" => id, "talk" => talk_params}) do
    talk = Repo.get!(Talk, id)
    changeset = Talk.changeset(talk, talk_params)

    case Repo.update(changeset) do
      {:ok, talk} ->
        conn
        |> put_flash(:info, "Talk updated successfully.")
        |> redirect(to: talk_path(conn, :show, talk))
      {:error, changeset} ->
        render(conn, "edit.html", talk: talk, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    talk = Repo.get!(Talk, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(talk)

    conn
    |> put_flash(:info, "Talk deleted successfully.")
    |> redirect(to: talk_path(conn, :index))
  end
end
