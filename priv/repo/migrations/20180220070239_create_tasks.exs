defmodule Tasktracker.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add(:details, :text)
      add(:title, :string, null: false)
      add(:owner_id, references(:users, on_delete: :delete_all), null: false)
      add(:assignee_id, references(:users, on_delete: :nilify_all))
      add(:status_id, references(:statustypes, on_delete: :nothing), null: false)

      timestamps()
    end

    create(index(:tasks, [:owner_id]))
    create(index(:tasks, [:assignee_id]))
    create(index(:tasks, [:status_id]))
  end
end
