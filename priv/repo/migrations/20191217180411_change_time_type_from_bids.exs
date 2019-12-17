defmodule Bidhype.Repo.Migrations.ChangeTimeTypeFromBids do
  use Ecto.Migration

  def change do
    alter table("bids") do
      modify :start_time, :naive_datetime
      modify :end_time, :naive_datetime
    end
  end
end
