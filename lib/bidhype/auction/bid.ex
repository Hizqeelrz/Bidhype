defmodule Bidhype.Auction.Bid do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bids" do
    field :avatar, :string
    field :item_name, :string
    field :max_price, :integer
    field :min_price, :integer
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(bid, attrs) do
    bid
    |> cast(attrs, [:item_name, :avatar, :min_price, :max_price])
    |> validate_required([:item_name, :avatar, :min_price, :max_price])
  end
end
