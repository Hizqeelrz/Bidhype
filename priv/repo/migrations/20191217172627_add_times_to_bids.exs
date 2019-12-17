defmodule Bidhype.Repo.Migrations.AddTimesToBids do
  use Ecto.Migration

  def change do
    alter table("bids") do
      add :start_time, :date
      add :end_time, :date
    end
  end
end
