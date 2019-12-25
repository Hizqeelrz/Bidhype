defmodule BidhypeWeb.PageController do
  use BidhypeWeb, :controller

  import Plug.Conn

  alias Bidhype.Auction
  alias Bidhype.Auction.Bid

  alias Bidhype.Accounts

  # plug :check_auth when action in [:live_bid]

  defp check_auth(conn, _args) do
    if user_id =  get_session(conn, :current_user_id) do
      current_user = Accounts.get_user!(user_id)

      conn
      |> assign(:current_user, current_user)
    else
      conn
      |> put_flash(:error, "You need to be signed in before Placing a Bid")
      |> redirect(to: Routes.session_path(conn, :new))
      |> halt()
    end
  end


  def index(conn, _params) do
    bids = Auction.list_bids()

    render(conn, "index.html", bids: bids)
  end

  def show_single_bid(conn, %{"id" => id}) do
    bid = Auction.get_bid!(id)
    render(conn, "single_bid.html", bid: bid)
  end

  def live_bid(conn, %{"id" => id}) do
    bid = Auction.get_bid!(id)
    live_render(conn, BidhypeWeb.BidLive, session: %{
      id: id,
    })
  end
end
