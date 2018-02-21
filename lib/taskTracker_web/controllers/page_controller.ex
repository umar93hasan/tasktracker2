defmodule TaskTrackerWeb.PageController do
  use TaskTrackerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def feed(conn, _params) do
    tasks = TaskTracker.TaskManager.list_tasks()
    changeset = TaskTracker.TaskManager.change_task(%TaskTracker.TaskManager.Task{})
    render conn, "feed.html", tasks: tasks, changeset: changeset
  end

end
