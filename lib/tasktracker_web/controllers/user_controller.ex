defmodule TasktrackerWeb.UserController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Accounts
  alias Tasktracker.Accounts.User

  def index(conn, _params) do
    current_user = conn.assigns[:current_user]
    users = Accounts.list_users()
    manages_map = Tasktracker.Accounts.manages_map_for(current_user.id)

    managees =
      manages_map
      |> Map.keys()

    all_user_ids = Tasktracker.Accounts.list_users() |> Enum.map(& &1.id)
    not_free = Tasktracker.Accounts.list_manages() |> Enum.map(& &1.managee_id) |> Enum.uniq()

    free_users = all_user_ids -- not_free

    manager_id =
      if current_user.managers do
        current_user.managers.id
      else
        "a"
      end

    render(
      conn,
      "index.html",
      users: users,
      managees: managees,
      free_users: free_users,
      manages_map: manages_map,
      manager_id: manager_id
    )
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: page_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    managees_names =
      Accounts.manages_map_for(id)
      |> Map.keys()
      |> Enum.map(fn id -> Accounts.get_user!(id) |> (& &1.username).() end)

    manager_id = Accounts.get_manager_id_for(id)

    manager_name =
      if manager_id do
        Accounts.get_manager_id_for(id)
        |> Accounts.get_user!()
        |> (& &1.username).()
      else
        "None"
      end

    render(
      conn,
      "show.html",
      user: user,
      managees_names: managees_names,
      manager_name: manager_name
    )
  end

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end
end
