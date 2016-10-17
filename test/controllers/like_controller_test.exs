defmodule Questhor.LikeControllerTest do
  use Questhor.ConnCase

  alias Questhor.Like
  @valid_attrs %{question_id: 42, user_id: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
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

  test "deletes chosen resource", %{conn: conn} do
    like = Repo.insert! %Like{}
    conn = delete conn, like_path(conn, :delete, like)
    assert response(conn, 204)
    refute Repo.get(Like, like.id)
  end
end
