defmodule TaskTracker.TaskManagerTest do
  use TaskTracker.DataCase

  alias TaskTracker.TaskManager

  describe "tasks" do
    alias TaskTracker.TaskManager.Task

    @valid_attrs %{completed: true, description: "some description", time_taken: 42, title: "some title"}
    @update_attrs %{completed: false, description: "some updated description", time_taken: 43, title: "some updated title"}
    @invalid_attrs %{completed: nil, description: nil, time_taken: nil, title: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TaskManager.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert TaskManager.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert TaskManager.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = TaskManager.create_task(@valid_attrs)
      assert task.completed == true
      assert task.description == "some description"
      assert task.time_taken == 42
      assert task.title == "some title"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TaskManager.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, task} = TaskManager.update_task(task, @update_attrs)
      assert %Task{} = task
      assert task.completed == false
      assert task.description == "some updated description"
      assert task.time_taken == 43
      assert task.title == "some updated title"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = TaskManager.update_task(task, @invalid_attrs)
      assert task == TaskManager.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = TaskManager.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> TaskManager.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = TaskManager.change_task(task)
    end
  end


  describe "timeblocks" do
    alias TaskTracker.TaskManager.TimeBlock

    @valid_attrs %{etime: ~N[2010-04-17 14:00:00.000000], stime: ~N[2010-04-17 14:00:00.000000]}
    @update_attrs %{etime: ~N[2011-05-18 15:01:01.000000], stime: ~N[2011-05-18 15:01:01.000000]}
    @invalid_attrs %{etime: nil, stime: nil}

    def time_block_fixture(attrs \\ %{}) do
      {:ok, time_block} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TaskManager.create_time_block()

      time_block
    end

    test "list_timeblocks/0 returns all timeblocks" do
      time_block = time_block_fixture()
      assert TaskManager.list_timeblocks() == [time_block]
    end

    test "get_time_block!/1 returns the time_block with given id" do
      time_block = time_block_fixture()
      assert TaskManager.get_time_block!(time_block.id) == time_block
    end

    test "create_time_block/1 with valid data creates a time_block" do
      assert {:ok, %TimeBlock{} = time_block} = TaskManager.create_time_block(@valid_attrs)
      assert time_block.etime == ~N[2010-04-17 14:00:00.000000]
      assert time_block.stime == ~N[2010-04-17 14:00:00.000000]
    end

    test "create_time_block/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TaskManager.create_time_block(@invalid_attrs)
    end

    test "update_time_block/2 with valid data updates the time_block" do
      time_block = time_block_fixture()
      assert {:ok, time_block} = TaskManager.update_time_block(time_block, @update_attrs)
      assert %TimeBlock{} = time_block
      assert time_block.etime == ~N[2011-05-18 15:01:01.000000]
      assert time_block.stime == ~N[2011-05-18 15:01:01.000000]
    end

    test "update_time_block/2 with invalid data returns error changeset" do
      time_block = time_block_fixture()
      assert {:error, %Ecto.Changeset{}} = TaskManager.update_time_block(time_block, @invalid_attrs)
      assert time_block == TaskManager.get_time_block!(time_block.id)
    end

    test "delete_time_block/1 deletes the time_block" do
      time_block = time_block_fixture()
      assert {:ok, %TimeBlock{}} = TaskManager.delete_time_block(time_block)
      assert_raise Ecto.NoResultsError, fn -> TaskManager.get_time_block!(time_block.id) end
    end

    test "change_time_block/1 returns a time_block changeset" do
      time_block = time_block_fixture()
      assert %Ecto.Changeset{} = TaskManager.change_time_block(time_block)
    end
  end
end
