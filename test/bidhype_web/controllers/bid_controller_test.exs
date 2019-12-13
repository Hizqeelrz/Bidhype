defmodule BidhypeWeb.BidControllerTest do
  use BidhypeWeb.ConnCase

  alias Bidhype.Auction

  @create_attrs %{avatar: "some avatar", item_name: "some item_name", max_price: 42, min_price: 42}
  @update_attrs %{avatar: "some updated avatar", item_name: "some updated item_name", max_price: 43, min_price: 43}
  @invalid_attrs %{avatar: nil, item_name: nil, max_price: nil, min_price: nil}

  def fixture(:bid) do
    {:ok, bid} = Auction.create_bid(@create_attrs)
    bid
  end

  describe "index" do
    test "lists all bids", %{conn: conn} do
      conn = get(conn, Routes.bid_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Bids"
    end
  end

  describe "new bid" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.bid_path(conn, :new))
      assert html_response(conn, 200) =~ "New Bid"
    end
  end

  describe "create bid" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.bid_path(conn, :create), bid: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.bid_path(conn, :show, id)

      conn = get(conn, Routes.bid_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Bid"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.bid_path(conn, :create), bid: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Bid"
    end
  end

  describe "edit bid" do
    setup [:create_bid]

    test "renders form for editing chosen bid", %{conn: conn, bid: bid} do
      conn = get(conn, Routes.bid_path(conn, :edit, bid))
      assert html_response(conn, 200) =~ "Edit Bid"
    end
  end

  describe "update bid" do
    setup [:create_bid]

    test "redirects when data is valid", %{conn: conn, bid: bid} do
      conn = put(conn, Routes.bid_path(conn, :update, bid), bid: @update_attrs)
      assert redirected_to(conn) == Routes.bid_path(conn, :show, bid)

      conn = get(conn, Routes.bid_path(conn, :show, bid))
      assert html_response(conn, 200) =~ "some updated avatar"
    end

    test "renders errors when data is invalid", %{conn: conn, bid: bid} do
      conn = put(conn, Routes.bid_path(conn, :update, bid), bid: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Bid"
    end
  end

  describe "delete bid" do
    setup [:create_bid]

    test "deletes chosen bid", %{conn: conn, bid: bid} do
      conn = delete(conn, Routes.bid_path(conn, :delete, bid))
      assert redirected_to(conn) == Routes.bid_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.bid_path(conn, :show, bid))
      end
    end
  end

  defp create_bid(_) do
    bid = fixture(:bid)
    {:ok, bid: bid}
  end
end
