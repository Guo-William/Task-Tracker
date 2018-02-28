defmodule TasktrackerWeb.ManagementController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Accounts
  alias Tasktracker.Accounts.Management

  action_fallback(TasktrackerWeb.FallbackController)

  def index(conn, _params) do
    managements = Accounts.list_managements()
    render(conn, "index.json", managements: managements)
  end

  def management_dashboard(conn, _params) do
    # task = Issues.get_task!(id)
    # render(conn, "index.html", management: task)
    # managements = Accounts.list_managements()
    render(conn, "index.html")
    # render(conn, "index.html")
  end

  def create(conn, %{"management" => management_params}) do
    with {:ok, %Management{} = management} <- Accounts.create_management(management_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", management_path(conn, :show, management))
      |> render("show.json", management: management)
    end
  end

  def show(conn, %{"id" => id}) do
    management = Accounts.get_management!(id)
    render(conn, "show.json", management: management)
  end

  def update(conn, %{"id" => id, "management" => management_params}) do
    management = Accounts.get_management!(id)

    with {:ok, %Management{} = management} <-
           Accounts.update_management(management, management_params) do
      render(conn, "show.json", management: management)
    end
  end

  def delete(conn, %{"id" => id}) do
    management = Accounts.get_management!(id)

    with {:ok, %Management{}} <- Accounts.delete_management(management) do
      send_resp(conn, :no_content, "")
    end
  end
end
