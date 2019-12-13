defmodule Bidhype.AuctionTest do
  use Bidhype.DataCase

  alias Bidhype.Auction

  describe "bids" do
    alias Bidhype.Auction.Bid

    @valid_attrs %{avatar: "some avatar", item_name: "some item_name", max_price: 42, min_price: 42}
    @update_attrs %{avatar: "some updated avatar", item_name: "some updated item_name", max_price: 43, min_price: 43}
    @invalid_attrs %{avatar: nil, item_name: nil, max_price: nil, min_price: nil}

    def bid_fixture(attrs \\ %{}) do
      {:ok, bid} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Auction.create_bid()

      bid
    end

    test "list_bids/0 returns all bids" do
      bid = bid_fixture()
      assert Auction.list_bids() == [bid]
    end

    test "get_bid!/1 returns the bid with given id" do
      bid = bid_fixture()
      assert Auction.get_bid!(bid.id) == bid
    end

    test "create_bid/1 with valid data creates a bid" do
      assert {:ok, %Bid{} = bid} = Auction.create_bid(@valid_attrs)
      assert bid.avatar == "some avatar"
      assert bid.item_name == "some item_name"
      assert bid.max_price == 42
      assert bid.min_price == 42
    end

    test "create_bid/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Auction.create_bid(@invalid_attrs)
    end

    test "update_bid/2 with valid data updates the bid" do
      bid = bid_fixture()
      assert {:ok, %Bid{} = bid} = Auction.update_bid(bid, @update_attrs)
      assert bid.avatar == "some updated avatar"
      assert bid.item_name == "some updated item_name"
      assert bid.max_price == 43
      assert bid.min_price == 43
    end

    test "update_bid/2 with invalid data returns error changeset" do
      bid = bid_fixture()
      assert {:error, %Ecto.Changeset{}} = Auction.update_bid(bid, @invalid_attrs)
      assert bid == Auction.get_bid!(bid.id)
    end

    test "delete_bid/1 deletes the bid" do
      bid = bid_fixture()
      assert {:ok, %Bid{}} = Auction.delete_bid(bid)
      assert_raise Ecto.NoResultsError, fn -> Auction.get_bid!(bid.id) end
    end

    test "change_bid/1 returns a bid changeset" do
      bid = bid_fixture()
      assert %Ecto.Changeset{} = Auction.change_bid(bid)
    end
  end
end
