defmodule Tasktracker.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Accounts.User
  alias Tasktracker.Accounts.Manage

  schema "users" do
    field(:email, :string)
    field(:username, :string)
    field(:is_manager, :boolean)
    has_one(:manager_manages, Manage, foreign_key: :manager_id)
    has_many(:managee_manages, Manage, foreign_key: :managee_id)
    has_one(:managers, through: [:manager_manages, :manager])
    has_many(:managees, through: [:managee_manages, :managee])

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :username, :is_manager])
    |> validate_required([:email, :username, :is_manager])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> unique_constraint(:username)
  end
end
