defmodule BidhypeWeb.BidLive do
  use Phoenix.LiveView
  alias BidhypeWeb.PageView
  alias Bidhype.Auction

  def render(assigns) do
    # IO.inspect assigns.bid
    PageView.render("bids.html", assigns)
  end

  def mount(%{path_params: %{"id" => bid_id}}, socket) do
    {:ok, assign(socket, :bid, Auction.get_bid!(bid_id))}
  end

  def handle_info({Auction, [:bid, _], _}, socket) do
    {:noreply, socket}
  end

  def handle_event("inc", _val, socket) do
    {:noreply, update(socket, :val, &(&1 + 5))}
  end

  defp fetch(socket) do
    # bid = Auction.get_bid!(id)
    assign(socket, :bids, Auction.list_bids() )
  end
end