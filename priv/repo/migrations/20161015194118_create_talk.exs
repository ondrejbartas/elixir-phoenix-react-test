defmodule Questhor.Repo.Migrations.CreateTalk do
  use Ecto.Migration

  def change do
    create table(:talks) do
      add :name, :string

      timestamps()
    end

  end
end
