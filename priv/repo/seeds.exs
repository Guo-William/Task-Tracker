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
alias Tasktracker.Accounts.User
alias Tasktracker.Issues.Task

Repo.insert!(%Statustype{
  statustype: "Completed"
})

Repo.insert!(%Statustype{
  statustype: "In progress"
})

Repo.insert!(%Statustype{
  statustype: "Unassigned"
})

Repo.insert!(%User{
  email: "Jack@Jack.com",
  username: "Jack"
})

Repo.insert!(%User{
  email: "Jill@Jill.com",
  username: "Jill"
})

Repo.insert!(%Task{
  title: "test",
  owner_id: 1,
  assignee_id: 2,
  status_id: 2
})
