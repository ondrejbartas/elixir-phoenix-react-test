defmodule Questhor.LikeTest do
  use Questhor.ModelCase

  alias Questhor.Like

  @valid_attrs %{question_id: 42, user_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Like.changeset(%Like{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Like.changeset(%Like{}, @invalid_attrs)
    refute changeset.valid?
  end
end
