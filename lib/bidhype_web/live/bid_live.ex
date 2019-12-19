defmodule BidhypeWeb.BidLive do
  use Phoenix.LiveView
  alias BidhypeWeb.PageView

  def render(assigns) do
    PageView.render("bids.html", assigns)
    # ~L"""
    # <div>
    #   <h1>$<%= @val %></h1>
    #   <button phx-click="inc" class="btn btn-sm btn-success" id="reset">Bid</button>
    # </div>
    # """
  end

  def mount(_session, socket) do
    {:ok, assign(socket, val: 0)}
  end

  def handle_event("inc", _val, socket) do
    {:noreply, update(socket, :val, &(&1 + 5))}
  end
end