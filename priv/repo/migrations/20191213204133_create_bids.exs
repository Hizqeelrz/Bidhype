defmodule Bidhype.Repo.Migrations.CreateBids do
  use Ecto.Migration

  def change do
    create table(:bids) do
      add :item_name, :string
      add :avatar, :string
      add :min_price, :integer
      add :max_price, :integer
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:bids, [:user_id])
  end
end
