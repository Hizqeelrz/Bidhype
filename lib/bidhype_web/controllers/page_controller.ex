defmodule BidhypeWeb.PageController do
  use BidhypeWeb, :controller

  alias Bidhype.Auction
  alias Bidhype.Auction.Bid

  def index(conn, _params) do
    bids = Auction.list_bids()

    render(conn, "index.html", bids: bids)
  end

  # def show_all_bids(conn, _params) do
  #   bids = Auction.list_bids()
  #   render(conn, "page.html", bids: bids)
  # end
end
