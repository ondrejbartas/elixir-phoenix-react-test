defmodule Questhor.LikeController do
  use Questhor.Web, :controller

  alias Questhor.Like

  def create(conn, %{"like" => like_params}) do
    changeset = Like.changeset(%Like{}, like_params)

    case Repo.insert(changeset) do
      {:ok, like} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", like_path(conn, :show, like))
        |> render("show.json", like: like)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Questhor.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    like = Repo.get!(Like, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(like)

    send_resp(conn, :no_content, "")
  end
end
