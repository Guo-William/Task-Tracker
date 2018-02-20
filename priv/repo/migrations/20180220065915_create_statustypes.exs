defmodule Tasktracker.Repo.Migrations.CreateStatustypes do
  use Ecto.Migration

  def change do
    create table(:statustypes) do
      add(:statustype, :string, null: false)

      timestamps()
    end

    create(unique_index(:statustypes, [:statustype]))
  end
end
