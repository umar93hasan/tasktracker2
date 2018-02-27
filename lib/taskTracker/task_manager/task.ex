defmodule TaskTracker.TaskManager.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias TaskTracker.TaskManager.Task
  alias TaskTracker.TaskManager.TimeBlock


  schema "tasks" do
    field :completed, :boolean, default: false
    field :description, :string
    field :title, :string
    #field :user_id, :id
    belongs_to :user, TaskTracker.Accounts.User
    #belongs_to :timeblock, TaskTracker.TaskManager.TimeBlock
    #has_one :timeblocks, TimeBlock, foreign_key: :id

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:title, :description, :completed, :user_id])
    |> validate_required([:title, :description, :completed])
  end
end
