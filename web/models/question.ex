defmodule Questhor.Question do
  use Questhor.Web, :model

  schema "questions" do
    field :text, :string
    belongs_to :talk, Questhor.Talk

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:text, :talk_id])
    |> validate_required([:text, :talk_id])
    |> validate_length(:text, min: 2)
  end
end
