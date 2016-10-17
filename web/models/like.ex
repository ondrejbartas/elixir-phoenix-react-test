defmodule Questhor.Like do
  use Questhor.Web, :model

  schema "likes" do
    belongs_to :user, Questhor.User
    belongs_to :question, Questhor.Question

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :question_id])
    |> validate_required([:user_id, :question_id])
  end
end
