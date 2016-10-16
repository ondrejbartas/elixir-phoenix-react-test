defmodule Questhor.User do
  use Questhor.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :token, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :token])
    |> validate_required([:name, :email, :token])
  end
end
