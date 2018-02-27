defmodule TaskTracker.Repo.Migrations.CreateTimeblocks do
  use Ecto.Migration

  def change do
    create table(:timeblocks) do
      add :stime, :naive_datetime
      add :etime, :naive_datetime
      add :task_id, references( :tasks, on_delete: :delete_all)
      timestamps()
    end

  create index(:timeblocks, [:task_id])
  end
end
