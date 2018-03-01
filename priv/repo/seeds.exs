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

appconstants = Appconstants.appconstants()

Repo.insert!(%Statustype{
  id: Map.get(appconstants, :COMPLETE_INDEX),
  statustype: Map.get(appconstants, :COMPLETE)
})

Repo.insert!(%Statustype{
  id: Map.get(appconstants, :INPROGRESS_INDEX),
  statustype: Map.get(appconstants, :INPROGRESS)
})

Repo.insert!(%Statustype{
  id: Map.get(appconstants, :NOTSTARTED_INDEX),
  statustype: Map.get(appconstants, :NOTSTARTED)
})

Repo.insert!(%User{
  email: "Jack@Jack.com",
  username: "Jack",
  is_manager: true
})

Repo.insert!(%User{
  email: "Jill@Jill.com",
  username: "Jill",
  is_manager: false
})

Repo.insert!(%Task{
  title: "test",
  owner_id: 1,
  assignee_id: 2,
  status_id: 2
})
