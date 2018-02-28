defmodule Tasktracker.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Accounts.User
  alias Tasktracker.Accounts.Manage

  schema "users" do
    field(:email, :string)
    field(:username, :string)
    field(:is_manager, :boolean)

    # all Manage records where I am the manager
    has_many(:manager_manages, Manage, foreign_key: :manager_id)
    # all Manage records where I am the managed
    has_one(:managee_manages, Manage, foreign_key: :managee_id)
    # User who manages me
    has_one(:managers, through: [:managee_manages, :manager])
    # all Users I manage
    has_many(:managees, through: [:manager_manages, :managee])

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
