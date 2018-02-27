defmodule TaskTrackerWeb.TaskController do
  use TaskTrackerWeb, :controller

  alias TaskTracker.TaskManager
  alias TaskTracker.TaskManager.Task
  alias TaskTracker.Accounts

  def index(conn, _params) do
    tasks = TaskManager.list_tasks()
    render(conn, "index.html", tasks: tasks)
  end

  def new(conn, _params) do
    changeset = TaskManager.change_task(%Task{})
    users = Accounts.list_underling_emails(conn.assigns.current_user.id)
    render(conn, "new.html", changeset: changeset, users: users)
  end

  def create(conn, %{"task" => task_params}) do
    users = Accounts.list_underling_emails(conn.assigns.current_user.id)
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
        tblocks = TaskManager.list_tblocks_of_task(id)
        render(conn, "show.html", task: task, tblocks: tblocks)
      end

      def edit(conn, %{"id" => id}) do
        task = TaskManager.get_task!(id)
        users = Accounts.list_underling_emails(conn.assigns.current_user.id)
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
