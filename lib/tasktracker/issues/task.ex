defmodule Tasktracker.Issues.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Issues.Task


  schema "tasks" do
    field :details, :string
    field :timespent, :integer
    field :title, :string
    field :owner_id, :id
    field :assignee_id, :id
    field :status_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:details, :title, :timespent])
    |> validate_required([:details, :title, :timespent])
  end
end
