defmodule TasktrackerWeb.ManagementControllerTest do
  use TasktrackerWeb.ConnCase

  alias Tasktracker.Accounts
  alias Tasktracker.Accounts.Management

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:management) do
    {:ok, management} = Accounts.create_management(@create_attrs)
    management
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all managements", %{conn: conn} do
      conn = get conn, management_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create management" do
    test "renders management when data is valid", %{conn: conn} do
      conn = post conn, management_path(conn, :create), management: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, management_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, management_path(conn, :create), management: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update management" do
    setup [:create_management]

    test "renders management when data is valid", %{conn: conn, management: %Management{id: id} = management} do
      conn = put conn, management_path(conn, :update, management), management: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, management_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn, management: management} do
      conn = put conn, management_path(conn, :update, management), management: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete management" do
    setup [:create_management]

    test "deletes chosen management", %{conn: conn, management: management} do
      conn = delete conn, management_path(conn, :delete, management)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, management_path(conn, :show, management)
      end
    end
  end

  defp create_management(_) do
    management = fixture(:management)
    {:ok, management: management}
  end
end
