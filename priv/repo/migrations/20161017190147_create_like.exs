defmodule Questhor.Repo.Migrations.CreateLike do
  use Ecto.Migration

  def change do
    create table(:likes) do
      add :user_id, :integer, index: true
      add :question_id, :integer, index: true

      timestamps()
    end

  end
end
