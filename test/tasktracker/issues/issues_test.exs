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

  describe "timeblocks" do
    alias Tasktracker.Issues.TimeBlock

    @valid_attrs %{end_time: "some end_time", start_time: "some start_time"}
    @update_attrs %{end_time: "some updated end_time", start_time: "some updated start_time"}
    @invalid_attrs %{end_time: nil, start_time: nil}

    def time_block_fixture(attrs \\ %{}) do
      {:ok, time_block} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Issues.create_time_block()

      time_block
    end

    test "list_timeblocks/0 returns all timeblocks" do
      time_block = time_block_fixture()
      assert Issues.list_timeblocks() == [time_block]
    end

    test "get_time_block!/1 returns the time_block with given id" do
      time_block = time_block_fixture()
      assert Issues.get_time_block!(time_block.id) == time_block
    end

    test "create_time_block/1 with valid data creates a time_block" do
      assert {:ok, %TimeBlock{} = time_block} = Issues.create_time_block(@valid_attrs)
      assert time_block.end_time == "some end_time"
      assert time_block.start_time == "some start_time"
    end

    test "create_time_block/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Issues.create_time_block(@invalid_attrs)
    end

    test "update_time_block/2 with valid data updates the time_block" do
      time_block = time_block_fixture()
      assert {:ok, time_block} = Issues.update_time_block(time_block, @update_attrs)
      assert %TimeBlock{} = time_block
      assert time_block.end_time == "some updated end_time"
      assert time_block.start_time == "some updated start_time"
    end

    test "update_time_block/2 with invalid data returns error changeset" do
      time_block = time_block_fixture()
      assert {:error, %Ecto.Changeset{}} = Issues.update_time_block(time_block, @invalid_attrs)
      assert time_block == Issues.get_time_block!(time_block.id)
    end

    test "delete_time_block/1 deletes the time_block" do
      time_block = time_block_fixture()
      assert {:ok, %TimeBlock{}} = Issues.delete_time_block(time_block)
      assert_raise Ecto.NoResultsError, fn -> Issues.get_time_block!(time_block.id) end
    end

    test "change_time_block/1 returns a time_block changeset" do
      time_block = time_block_fixture()
      assert %Ecto.Changeset{} = Issues.change_time_block(time_block)
    end
  end

  describe "timeblocks" do
    alias Tasktracker.Issues.TimeBlock

    @valid_attrs %{end_time: "2010-04-17 14:00:00.000000Z", start_time: "2010-04-17 14:00:00.000000Z"}
    @update_attrs %{end_time: "2011-05-18 15:01:01.000000Z", start_time: "2011-05-18 15:01:01.000000Z"}
    @invalid_attrs %{end_time: nil, start_time: nil}

    def time_block_fixture(attrs \\ %{}) do
      {:ok, time_block} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Issues.create_time_block()

      time_block
    end

    test "list_timeblocks/0 returns all timeblocks" do
      time_block = time_block_fixture()
      assert Issues.list_timeblocks() == [time_block]
    end

    test "get_time_block!/1 returns the time_block with given id" do
      time_block = time_block_fixture()
      assert Issues.get_time_block!(time_block.id) == time_block
    end

    test "create_time_block/1 with valid data creates a time_block" do
      assert {:ok, %TimeBlock{} = time_block} = Issues.create_time_block(@valid_attrs)
      assert time_block.end_time == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
      assert time_block.start_time == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
    end

    test "create_time_block/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Issues.create_time_block(@invalid_attrs)
    end

    test "update_time_block/2 with valid data updates the time_block" do
      time_block = time_block_fixture()
      assert {:ok, time_block} = Issues.update_time_block(time_block, @update_attrs)
      assert %TimeBlock{} = time_block
      assert time_block.end_time == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
      assert time_block.start_time == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
    end

    test "update_time_block/2 with invalid data returns error changeset" do
      time_block = time_block_fixture()
      assert {:error, %Ecto.Changeset{}} = Issues.update_time_block(time_block, @invalid_attrs)
      assert time_block == Issues.get_time_block!(time_block.id)
    end

    test "delete_time_block/1 deletes the time_block" do
      time_block = time_block_fixture()
      assert {:ok, %TimeBlock{}} = Issues.delete_time_block(time_block)
      assert_raise Ecto.NoResultsError, fn -> Issues.get_time_block!(time_block.id) end
    end

    test "change_time_block/1 returns a time_block changeset" do
      time_block = time_block_fixture()
      assert %Ecto.Changeset{} = Issues.change_time_block(time_block)
    end
  end
end
