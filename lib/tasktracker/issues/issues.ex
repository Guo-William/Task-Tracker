defmodule Tasktracker.Issues do
  @moduledoc """
  The Issues context.
  """

  import Ecto.Query, warn: false
  alias Tasktracker.Repo

  alias Tasktracker.Issues.Statustype

  @doc """
  Returns the list of statustypes.

  ## Examples

      iex> list_statustypes()
      [%Statustype{}, ...]

  """
  def list_statustypes do
    Repo.all(Statustype)
  end

  @doc """
  Gets a single statustype.

  Raises `Ecto.NoResultsError` if the Statustype does not exist.

  ## Examples

      iex> get_statustype!(123)
      %Statustype{}

      iex> get_statustype!(456)
      ** (Ecto.NoResultsError)

  """
  def get_statustype!(id), do: Repo.get!(Statustype, id)

  @doc """
  Creates a statustype.

  ## Examples

      iex> create_statustype(%{field: value})
      {:ok, %Statustype{}}

      iex> create_statustype(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_statustype(attrs \\ %{}) do
    %Statustype{}
    |> Statustype.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a statustype.

  ## Examples

      iex> update_statustype(statustype, %{field: new_value})
      {:ok, %Statustype{}}

      iex> update_statustype(statustype, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_statustype(%Statustype{} = statustype, attrs) do
    statustype
    |> Statustype.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Statustype.

  ## Examples

      iex> delete_statustype(statustype)
      {:ok, %Statustype{}}

      iex> delete_statustype(statustype)
      {:error, %Ecto.Changeset{}}

  """
  def delete_statustype(%Statustype{} = statustype) do
    Repo.delete(statustype)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking statustype changes.

  ## Examples

      iex> change_statustype(statustype)
      %Ecto.Changeset{source: %Statustype{}}

  """
  def change_statustype(%Statustype{} = statustype) do
    Statustype.changeset(statustype, %{})
  end

  alias Tasktracker.Issues.Task

  @doc """
  Returns the list of tasks.

  ## Examples

      iex> list_tasks()
      [%Task{}, ...]

  """
  def list_tasks do
    Repo.all(Task)
    |> Repo.preload(:owner)
    |> Repo.preload(:assignee)
    |> Repo.preload(:status)
  end

  @doc """
  Gets a single task.

  Raises `Ecto.NoResultsError` if the Task does not exist.

  ## Examples

      iex> get_task!(123)
      %Task{}

      iex> get_task!(456)
      ** (Ecto.NoResultsError)

  """
  def get_task!(id) do
    Repo.get!(Task, id)
    |> Repo.preload(:owner)
    |> Repo.preload(:assignee)
    |> Repo.preload(:status)
  end

  @doc """
  Creates a task.

  ## Examples

      iex> create_task(%{field: value})
      {:ok, %Task{}}

      iex> create_task(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Map.put(:status_id, 3)
    |> Repo.insert()
  end

  @doc """
  Updates a task.

  ## Examples

      iex> update_task(task, %{field: new_value})
      {:ok, %Task{}}

      iex> update_task(task, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_task(%Task{} = task, attrs) do
    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Task.

  ## Examples

      iex> delete_task(task)
      {:ok, %Task{}}

      iex> delete_task(task)
      {:error, %Ecto.Changeset{}}

  """
  def delete_task(%Task{} = task) do
    Repo.delete(task)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking task changes.

  ## Examples

      iex> change_task(task)
      %Ecto.Changeset{source: %Task{}}

  """
  def change_task(%Task{} = task) do
    Task.changeset(task, %{})
  end

  alias Tasktracker.Issues.TimeBlock

  @doc """
  Returns the list of timeblocks.

  ## Examples

      iex> list_timeblocks()
      [%TimeBlock{}, ...]

  """
  def list_timeblocks do
    Repo.all(TimeBlock)
  end

  @doc """
  Gets a single time_block.

  Raises `Ecto.NoResultsError` if the Time block does not exist.

  ## Examples

      iex> get_time_block!(123)
      %TimeBlock{}

      iex> get_time_block!(456)
      ** (Ecto.NoResultsError)

  """
  def get_time_block!(id), do: Repo.get!(TimeBlock, id)

  @doc """
  Creates a time_block.

  ## Examples

      iex> create_time_block(%{field: value})
      {:ok, %TimeBlock{}}

      iex> create_time_block(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_time_block(attrs \\ %{}) do
    %TimeBlock{}
    |> TimeBlock.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a time_block.

  ## Examples

      iex> update_time_block(time_block, %{field: new_value})
      {:ok, %TimeBlock{}}

      iex> update_time_block(time_block, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_time_block(%TimeBlock{} = time_block, attrs) do
    time_block
    |> TimeBlock.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a TimeBlock.

  ## Examples

      iex> delete_time_block(time_block)
      {:ok, %TimeBlock{}}

      iex> delete_time_block(time_block)
      {:error, %Ecto.Changeset{}}

  """
  def delete_time_block(%TimeBlock{} = time_block) do
    Repo.delete(time_block)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking time_block changes.

  ## Examples

      iex> change_time_block(time_block)
      %Ecto.Changeset{source: %TimeBlock{}}

  """
  def change_time_block(%TimeBlock{} = time_block) do
    TimeBlock.changeset(time_block, %{})
  end
end
