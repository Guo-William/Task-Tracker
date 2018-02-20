defmodule Tasktracker.Issues.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Issues.Task

  schema "tasks" do
    field(:details, :string)
    field(:timespent, :integer)
    field(:title, :string)
    belongs_to(:owner, Tasktracker.Accounts.User)
    belongs_to(:assignee, Tasktracker.Accounts.User)
    # field(:assignee_id, :id)
    belongs_to(:status, Tasktracker.Issues.Statustype)
    # field(:status_id, :id)

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:details, :title, :timespent, :owner_id, :status_id, :assignee_id])
    |> validate_required([:title])
    |> fixTimeSpent
  end

  defp fixTimeSpent(changeset) do
    userTime = Kernel.trunc(get_field(changeset, :timespent) / 15 + 1) * 15

    changeset
    |> change(timespent: userTime)
  end
end
