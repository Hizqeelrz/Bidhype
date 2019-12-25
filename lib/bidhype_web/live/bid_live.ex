defmodule BidhypeWeb.BidLive do
  use Phoenix.LiveView
  alias BidhypeWeb.PageView
  alias Bidhype.Auction

  def render(assigns) do
    PageView.render("bids.html", assigns)
  end

  def mount(%{id: id}, socket) do
    if connected?(socket), do: Auction.subscribe()
    {:ok, assign(socket, :bid, Auction.get_bid!(id))}
  end

  def handle_info({Auction, [:bid, _], _}, socket) do
    {:noreply, socket}
  end

  def handle_event("price_bid", val, socket) do
    IO.inspect "handle_event"
    bid = Auction.get_bid!(socket.assigns.bid.id)

    auction_bid(bid, socket)
  end

  defp fetch(socket) do
    assign(socket, :bids, Auction.list_bids() )
  end

  defp auction_bid(val, socket) do
    if (val.price_bid == 1) do
      Auction.update_bid(val, %{price_bid: val.price_bid + 4})
      {:noreply, update(socket, :price_bid, val)}  
    end
    if (val.price_bid < 250) do
      Auction.update_bid(val, %{price_bid: val.price_bid + 5})
      {:noreply, update(socket, :price_bid, val)}
    end
    if (val.price_bid >= 250) do
      Auction.update_bid(val, %{price_bid: val.price_bid + 25})
      {:noreply, update(socket, :price_bid, val)}
    end
  end
end