defmodule Tasktracker.IssuesTest do
  use Tasktracker.DataCase

  alias Tasktracker.Issues

  describe "statustypes" do
    alias Tasktracker.Issues.Statustype

    @valid_attrs %{statustype: "some statustype"}
    @update_attrs %{statustype: "some updated statustype"}
    @invalid_attrs %{statustype: nil}

    def statustype_fixture(attrs \\ %{}) do
      {:ok, statustype} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Issues.create_statustype()

      statustype
    end

    test "list_statustypes/0 returns all statustypes" do
      statustype = statustype_fixture()
      assert Issues.list_statustypes() == [statustype]
    end

    test "get_statustype!/1 returns the statustype with given id" do
      statustype = statustype_fixture()
      assert Issues.get_statustype!(statustype.id) == statustype
    end

    test "create_statustype/1 with valid data creates a statustype" do
      assert {:ok, %Statustype{} = statustype} = Issues.create_statustype(@valid_attrs)
      assert statustype.statustype == "some statustype"
    end

    test "create_statustype/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Issues.create_statustype(@invalid_attrs)
    end

    test "update_statustype/2 with valid data updates the statustype" do
      statustype = statustype_fixture()
      assert {:ok, statustype} = Issues.update_statustype(statustype, @update_attrs)
      assert %Statustype{} = statustype
      assert statustype.statustype == "some updated statustype"
    end

    test "update_statustype/2 with invalid data returns error changeset" do
      statustype = statustype_fixture()
      assert {:error, %Ecto.Changeset{}} = Issues.update_statustype(statustype, @invalid_attrs)
      assert statustype == Issues.get_statustype!(statustype.id)
    end

    test "delete_statustype/1 deletes the statustype" do
      statustype = statustype_fixture()
      assert {:ok, %Statustype{}} = Issues.delete_statustype(statustype)
      assert_raise Ecto.NoResultsError, fn -> Issues.get_statustype!(statustype.id) end
    end

    test "change_statustype/1 returns a statustype changeset" do
      statustype = statustype_fixture()
      assert %Ecto.Changeset{} = Issues.change_statustype(statustype)
    end
  end

  describe "tasks" do
    alias Tasktracker.Issues.Task

    @valid_attrs %{details: "some details", timespent: 42, title: "some title"}
    @update_attrs %{details: "some updated details", timespent: 43, title: "some updated title"}
    @invalid_attrs %{details: nil, timespent: nil, title: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Issues.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Issues.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Issues.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = Issues.create_task(@valid_attrs)
      assert task.details == "some details"
      assert task.timespent == 42
      assert task.title == "some title"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Issues.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, task} = Issues.update_task(task, @update_attrs)
      assert %Task{} = task
      assert task.details == "some updated details"
      assert task.timespent == 43
      assert task.title == "some updated title"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Issues.update_task(task, @invalid_attrs)
      assert task == Issues.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Issues.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Issues.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Issues.change_task(task)
    end
  end
end
