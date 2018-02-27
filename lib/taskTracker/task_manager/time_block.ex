defmodule TaskTracker.TaskManager.TimeBlock do
  use Ecto.Schema
  import Ecto.Changeset
  alias TaskTracker.TaskManager.TimeBlock


  schema "timeblocks" do
    field :etime, :naive_datetime
    field :stime, :naive_datetime

    belongs_to :task, TaskTracker.TaskManager.Task

    timestamps()
  end

  @doc false
  def changeset(%TimeBlock{} = time_block, attrs) do
    time_block
    |> cast(attrs, [:stime, :etime, :task_id])
    |> validate_required([:stime, :etime])
  end
end
