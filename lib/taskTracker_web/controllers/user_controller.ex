defmodule TaskTrackerWeb.UserController do
  use TaskTrackerWeb, :controller

  alias TaskTracker.Accounts
  alias TaskTracker.Accounts.User

  def index(conn, _params) do
    users = Accounts.list_userdata()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    existing_users = Accounts.list_user_emails()
    render(conn, "new.html", changeset: changeset, mgrs: existing_users)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        existing_users = Accounts.list_user_emails()
        render(conn, "new.html", changeset: changeset, mgrs: existing_users)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    mgr = Accounts.get_name_by_id(user.mgr_id)
    if mgr do
      render(conn, "show.html", user: user, mgr: mgr)
    else
      render(conn, "show.html", user: user, mgr: "No Manager Assigned")
    end
  end

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    existing_users = Accounts.list_user_emails()
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, mgrs: existing_users, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: page_path(conn, :feed))
  end
end
