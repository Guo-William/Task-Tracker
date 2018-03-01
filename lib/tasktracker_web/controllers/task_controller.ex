defmodule TasktrackerWeb.TaskController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Issues
  alias Tasktracker.Issues.Task

  def index(conn, _params) do
    tasks = Issues.list_tasks()
    appconstants = Appconstants.appconstants()

    completedTasks =
      tasks
      |> Enum.filter(fn task ->
        task.status.id == Map.get(appconstants, :COMPLETE_INDEX)
      end)

    inProgressTasks =
      tasks
      |> Enum.filter(fn task ->
        task.status.id == Map.get(appconstants, :INPROGRESS_INDEX)
      end)

    unstartedTasks =
      tasks
      |> Enum.filter(fn task ->
        task.status.id == Map.get(appconstants, :NOTSTARTED_INDEX)
      end)

    render(
      conn,
      "separate.html",
      completedTasks: completedTasks,
      inProgressTasks: inProgressTasks,
      unstartedTasks: unstartedTasks
    )
  end

  def new(conn, _params) do
    current_user = conn.assigns[:current_user]

    all_managees =
      Tasktracker.Accounts.get_user(current_user.id).managees
      |> Enum.map(& &1.id)
      |> Enum.map(&Tasktracker.Accounts.get_user(&1))
      |> Enum.map(fn oneUser -> {oneUser.username, oneUser.id} end)
      |> Enum.concat([{"select assignee", nil}])

    allStatuses =
      Tasktracker.Issues.list_statustypes()
      |> Enum.map(fn oneStatus -> {oneStatus.statustype, oneStatus.id} end)
      |> Enum.reverse()

    changeset = Issues.change_task(%Task{})

    render(
      conn,
      "new.html",
      changeset: changeset,
      all_managees: all_managees,
      allStatuses: allStatuses
    )
  end

  def create(conn, %{"task" => task_params}) do
    case Issues.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Issues.get_task!(id)
    render(conn, "show.html", task: task)
  end

  def edit(conn, %{"id" => id}) do
    current_user = conn.assigns[:current_user]

    all_managees =
      Tasktracker.Accounts.get_user(current_user.id).managees
      |> Enum.map(& &1.id)
      |> Enum.map(&Tasktracker.Accounts.get_user(&1))
      |> Enum.map(fn oneUser -> {oneUser.username, oneUser.id} end)
      |> Enum.concat([{"select assignee", nil}])

    allStatuses =
      Tasktracker.Issues.list_statustypes()
      |> Enum.map(fn oneStatus -> {oneStatus.statustype, oneStatus.id} end)
      |> Enum.reverse()

    task = Issues.get_task!(id)
    changeset = Issues.change_task(task)

    render(
      conn,
      "edit.html",
      task: task,
      changeset: changeset,
      all_managees: all_managees,
      allStatuses: allStatuses
    )
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Issues.get_task!(id)

    case Issues.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Issues.get_task!(id)
    {:ok, _task} = Issues.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: task_path(conn, :index))
  end

  def team(conn, _params) do
    current_user = conn.assigns[:current_user]
    appconstants = Appconstants.appconstants()

    all_managees =
      Tasktracker.Accounts.get_user(current_user.id).managees
      |> Enum.map(& &1.id)

    tasks =
      Issues.list_tasks()
      |> Enum.filter(fn task -> Enum.member?(all_managees, task.assignee_id) end)

    completedTasks =
      tasks
      |> Enum.filter(fn task ->
        task.status.id == Map.get(appconstants, :COMPLETE_INDEX)
      end)

    inProgressTasks =
      tasks
      |> Enum.filter(fn task ->
        task.status.id == Map.get(appconstants, :INPROGRESS_INDEX)
      end)

    unstartedTasks =
      tasks
      |> Enum.filter(fn task ->
        task.status.id == Map.get(appconstants, :NOTSTARTED_INDEX)
      end)

    render(
      conn,
      "team.html",
      completedTasks: completedTasks,
      inProgressTasks: inProgressTasks,
      unstartedTasks: unstartedTasks
    )
  end
end
