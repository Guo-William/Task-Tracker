# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Tasktracker.Repo.insert!(%Tasktracker.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Tasktracker.Repo
alias Tasktracker.Issues.Statustype

Repo.insert!(%Statustype{
  statustype: "Completed"
})

Repo.insert!(%Statustype{
  statustype: "Inprogress"
})

Repo.insert!(%Statustype{
  statustype: "Unassigned"
})
