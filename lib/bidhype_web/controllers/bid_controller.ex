defmodule BidhypeWeb.BidController do
  use BidhypeWeb, :controller

  alias Bidhype.Auction
  alias Bidhype.Auction.Bid

  def index(conn, _params) do
    IO.inspect conn
    bids = Auction.list_bids()
    render(conn, "index.html", bids: bids)
  end

  def new(conn, _params) do
    changeset = Auction.change_bid(%Bid{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"bid" => bid_params}) do
    case Auction.create_bid(bid_params) do
      {:ok, bid} ->
        conn
        |> put_flash(:info, "Bid created successfully.")
        |> redirect(to: Routes.bid_path(conn, :show, bid))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    bid = Auction.get_bid!(id)
    render(conn, "show.html", bid: bid)
  end

  def edit(conn, %{"id" => id}) do
    bid = Auction.get_bid!(id)
    changeset = Auction.change_bid(bid)
    render(conn, "edit.html", bid: bid, changeset: changeset)
  end

  def update(conn, %{"id" => id, "bid" => bid_params}) do
    bid = Auction.get_bid!(id)

    case Auction.update_bid(bid, bid_params) do
      {:ok, bid} ->
        conn
        |> put_flash(:info, "Bid updated successfully.")
        |> redirect(to: Routes.bid_path(conn, :show, bid))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", bid: bid, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    bid = Auction.get_bid!(id)
    {:ok, _bid} = Auction.delete_bid(bid)

    conn
    |> put_flash(:info, "Bid deleted successfully.")
    |> redirect(to: Routes.bid_path(conn, :index))
  end
end
