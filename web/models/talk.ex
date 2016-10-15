defmodule Questhor.Talk do
  use Questhor.Web, :model

  schema "talks" do
    field :name, :string
    has_many :questions, Questhor.Question

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
    |> validate_length(:name, min: 2)
  end
end
