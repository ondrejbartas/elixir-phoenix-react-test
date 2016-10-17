defmodule Questhor.Repo.Migrations.CreateQuestion do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add :text, :string
      add :talk_id, :integer, index: true
      add :likes, :integer, default: 0

      timestamps()
    end
  end
end
