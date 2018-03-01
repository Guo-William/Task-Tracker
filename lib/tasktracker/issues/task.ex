defmodule Tasktracker.Issues.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Issues.Task

  schema "tasks" do
    field(:details, :string)
    field(:title, :string)
    belongs_to(:owner, Tasktracker.Accounts.User)
    belongs_to(:assignee, Tasktracker.Accounts.User)
    belongs_to(:status, Tasktracker.Issues.Statustype)

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:details, :title, :owner_id, :status_id, :assignee_id])
    |> validate_required([:title])
  end
end
