defmodule Tasktracker.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:email, :string, null: false)
      add(:username, :string, null: false)
      add(:is_manager, :boolean, null: false)
      timestamps()
    end

    create(unique_index(:users, [:email]))
    create(unique_index(:users, [:username]))
  end
end
