defmodule TaskTracker.TaskManager.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias TaskTracker.TaskManager.Task


  schema "tasks" do
    field :completed, :boolean, default: false
    field :description, :string
    field :time_taken, :integer, default: 0
    field :title, :string
    #field :user_id, :id
    belongs_to :user, TaskTracker.Accounts.User
    

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:title, :description, :time_taken, :completed, :user_id])
    |> validate_required([:title, :description, :time_taken, :completed])
  end
end
