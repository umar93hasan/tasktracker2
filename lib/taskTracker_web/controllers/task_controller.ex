defmodule TaskTrackerWeb.TaskController do
  use TaskTrackerWeb, :controller
  import Ecto.Query, warn: false
  alias TaskTracker.TaskManager
  alias TaskTracker.TaskManager.Task
  alias TaskTracker.Accounts.User
  alias TaskTracker.Accounts
  alias TaskTracker.Repo
  
  def index(conn, _params) do
    tasks = TaskManager.list_tasks()
    render(conn, "index.html", tasks: tasks)
  end

  def new(conn, _params) do
    changeset = TaskManager.change_task(%Task{}) 
    users = from(u in User, select: {u.email,u.id})
    |> Repo.all()
    render(conn, "new.html", changeset: changeset, users: users)
  end

  def create(conn, %{"task" => task_params}) do
     users = from(u in User, select: {u.email,u.id})
     |> Repo.all()
    case TaskManager.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, users: users)
    end
  end

  def show(conn, %{"id" => id}) do
    task = TaskManager.get_task!(id)
    render(conn, "show.html", task: task)
  end

  def edit(conn, %{"id" => id}) do
    task = TaskManager.get_task!(id)
    users = from(u in User, select: {u.email,u.id})
    |> Repo.all()
    changeset = TaskManager.change_task(task)
    render(conn, "edit.html", task: task, changeset: changeset, users: users)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = TaskManager.get_task!(id)

    case TaskManager.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = TaskManager.get_task!(id)
    {:ok, _task} = TaskManager.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: page_path(conn, :feed))
  end
end
