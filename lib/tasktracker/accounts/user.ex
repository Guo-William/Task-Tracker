defmodule Tasktracker.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Accounts.User
  alias Tasktracker.Accounts.Management

  schema "users" do
    field(:email, :string)
    field(:username, :string)
    field(:is_manager, :boolean)
    has_one(:manager_user, Management, foreign_key: :manager_id)
    has_many(:managed_user, Management, foreign_key: :managed_id)
    has_one(:managers, through: [:manager_user, :manager])
    has_many(:manageds, through: [:managed_user, :managed])

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
