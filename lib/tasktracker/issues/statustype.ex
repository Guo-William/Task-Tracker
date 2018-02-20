defmodule Tasktracker.Issues.Statustype do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Issues.Statustype


  schema "statustypes" do
    field :statustype, :string

    timestamps()
  end

  @doc false
  def changeset(%Statustype{} = statustype, attrs) do
    statustype
    |> cast(attrs, [:statustype])
    |> validate_required([:statustype])
    |> unique_constraint(:statustype)
  end
end
