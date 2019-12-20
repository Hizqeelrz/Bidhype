defmodule Bidhype.Repo.Migrations.AddPriceToBids do
  use Ecto.Migration

  def change do
    alter table("bids") do
      add :price_bid, :integer
    end
  end
end
