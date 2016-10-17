defmodule Questhor.JSONTalkTest do
  use Questhor.ModelCase

  alias Questhor.JSONTalk

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = JSONTalk.changeset(%JSONTalk{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = JSONTalk.changeset(%JSONTalk{}, @invalid_attrs)
    refute changeset.valid?
  end
end
