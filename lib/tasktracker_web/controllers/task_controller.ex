defmodule TasktrackerWeb.TaskController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Issues
  alias Tasktracker.Issues.Task

  def index(conn, _params) do
    tasks = Issues.list_tasks()
    render(conn, "index.html", tasks: tasks)
  end

  def new(conn, _params) do
    allUsers =
      Tasktracker.Accounts.list_users()
      |> Enum.map(fn oneUser -> {oneUser.username, oneUser.id} end)
      |> Enum.concat([{"select assignee", nil}])

    allStatuses =
      Tasktracker.Issues.list_statustypes()
      |> Enum.map(fn oneStatus -> {oneStatus.statustype, oneStatus.id} end)
      |> Enum.reverse()

    timespent = 0
    changeset = Issues.change_task(%Task{})

    render(
      conn,
      "new.html",
      changeset: changeset,
      allUsers: allUsers,
      allStatuses: allStatuses,
      timespent: timespent
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
    allUsers =
      Tasktracker.Accounts.list_users()
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
      allUsers: allUsers,
      allStatuses: allStatuses,
      timespent: task.timespent
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
end
