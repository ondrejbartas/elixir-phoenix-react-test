defmodule Questhor.TalkTest do
  use Questhor.ModelCase

  alias Questhor.Talk

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Talk.changeset(%Talk{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Talk.changeset(%Talk{}, @invalid_attrs)
    refute changeset.valid?
  end
end
