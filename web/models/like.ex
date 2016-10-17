defmodule Questhor.Like do
  use Questhor.Web, :model

  schema "likes" do
    field :user_id, :integer
    field :question_id, :integer

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
