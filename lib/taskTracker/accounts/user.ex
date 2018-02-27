defmodule TaskTracker.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias TaskTracker.Accounts.User


  schema "users" do
    field :email, :string
    field :name, :string

    belongs_to :mgr, User
    has_many :users, User, foreign_key: :mgr_id
    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :name, :mgr_id])
    |> validate_required([:email, :name])
    |> unique_constraint(:email)
  end
end
