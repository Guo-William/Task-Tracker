defmodule Tasktracker.Accounts.Management do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Accounts.Management
  alias Tasktracker.Accounts.User

  schema "managements" do
    belongs_to(:manager_id, User)
    belongs_to(:managed_id, User)

    timestamps()
  end

  @doc false
  def changeset(%Management{} = management, attrs) do
    management
    |> cast(attrs, [:manager_id, :managed_id])
    |> validate_required([:manager_id, :managed_id])
  end
end
