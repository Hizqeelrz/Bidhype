defmodule Bidhype.Auction.Bid do
  use Ecto.Schema
  import Ecto.Changeset

  alias Date

  schema "bids" do
    field :avatar, :string
    field :item_name,   :string
    field :max_price,   :integer
    field :min_price,   :integer
    field :start_time,  :date
    field :end_time,    :date
    # field :user_id, :id

    belongs_to :seller_name, Bidhype.Accounts.User, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(bid, attrs) do
    bid
    |> cast(attrs, [:item_name, :avatar, :min_price, :max_price, :user_id, :start_time, :end_time])
    |> validate_required([:item_name, :start_time, :end_time])
    # |> validate_dates()
  end

  # defp validate_dates(changeset) do
  #   start_time = get_field(changeset, :start_time)
  #   end_time = get_field(changeset, :end_time)

  #   case Date.compare(start_time, end_time) do
  #     :gt -> add_error(changeset, :end_time, "cannot be later than 'start_time'")
  #     _ -> changeset
  #   end
  # end
end
