defmodule TaskTracker.Repo.Migrations.AlterUserTable do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :mgr_id, references( :users, on_delete: :delete_all)
    end

    create unique_index(:users, [:email])
  end
end
