defmodule BidhypeWeb.PageController do
  use BidhypeWeb, :controller

  alias Bidhype.Auction
  alias Bidhype.Auction.Bid

  def index(conn, _params) do
    bids = Auction.list_bids()

    render(conn, "index.html", bids: bids)
  end

  def show_single_bid(conn, %{"id" => id}) do
    bid = Auction.get_bid!(id)
    render(conn, "single_bid.html", bid: bid)
  end
end
