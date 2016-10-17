defmodule Questhor.LikeControllerTest do
  use Questhor.ConnCase

  alias Questhor.Like
  @valid_attrs %{question_id: 42, user_id: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, like_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    like = Repo.insert! %Like{}
    conn = get conn, like_path(conn, :show, like)
    assert json_response(conn, 200)["data"] == %{"id" => like.id,
      "user_id" => like.user_id,
      "question_id" => like.question_id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, like_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, like_path(conn, :create), like: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Like, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, like_path(conn, :create), like: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    like = Repo.insert! %Like{}
    conn = put conn, like_path(conn, :update, like), like: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Like, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    like = Repo.insert! %Like{}
    conn = put conn, like_path(conn, :update, like), like: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    like = Repo.insert! %Like{}
    conn = delete conn, like_path(conn, :delete, like)
    assert response(conn, 204)
    refute Repo.get(Like, like.id)
  end
end
