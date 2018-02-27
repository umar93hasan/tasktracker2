defmodule TaskTrackerWeb.PageController do
  use TaskTrackerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def feed(conn, _params) do
    tasks = TaskTracker.TaskManager.list_tasks_of_user(conn.assigns.current_user.id)
    utasks = TaskTracker.TaskManager.list_tasks_of_underlings(conn.assigns.current_user.id)
    my_mgr = TaskTracker.Accounts.get_manager_name(conn.assigns.current_user.id)
    underlings = TaskTracker.Accounts.get_underlings(conn.assigns.current_user.id)
    IO.inspect underlings
    changeset = TaskTracker.TaskManager.change_task(%TaskTracker.TaskManager.Task{})
    render conn, "feed.html", tasks: tasks, utasks: utasks, my_mgr: my_mgr, underlings: underlings, changeset: changeset
  end

end
