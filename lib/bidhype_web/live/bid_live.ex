defmodule BidhypeWeb.BidLive do
  use Phoenix.LiveView
  alias BidhypeWeb.PageView
  alias Bidhype.Auction
  alias Bidhype.Auction.Bid

  def render(assigns) do
    PageView.render("bids.html", assigns)
  end

  def mount(%{id: id}, socket) do
    if connected?(socket), do: Auction.subscribe()
    changeset = Auction.change_bid(%Bid{})

    {:ok, assign(socket, 
          bid: Auction.get_bid!(id),
          mode: :inactive,
          elapsed: 0,
          current_pomodoro: 0,
          minutes: 0,
          seconds: 10,
          changeset: changeset,
          notification_id: nil
          )}
  end

  # liveview events
  def handle_event("price_bid", val, socket) do
    # :timer.send_interval(1000, self(), :tick)

    bid = Auction.get_bid!(socket.assigns.bid.id)

    # Auction.update_bid(bid, %{price_bid: bid.price_bid + 4})
    # {:noreply, update(socket, :price_bid, bid)}
    # |> activate()
    # |> assign(current_pomodoro: 0)


    auction_bid(bid, socket)
  end

  def handle_info(:tick, socket) do
    update_socket = put_timer(socket)

    if update_socket.assigns.current_pomodoro == Enum.count(update_socket.assigns.tasks) do
      {:stop,
       update_socket
       |> put_flash(:info, "Finish all pomodoro!")
       |> redirect(
         to: Routes.live_path(update_socket, PomodoroLive.Show, update_socket.assigns.room.hash)
       )}
    else
      {:noreply, update_socket}
    end
  end

  # Live PubSub event

  def handle_info({Auction, [:bid, _], _}, socket) do
    {:noreply, Auction.get_bid!(socket.assigns.bid.id)}
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

  # defp activate(socket) do
  #   socket
  #   |> assign(
  #     mode: :active,
  #     elapsed: 0,
  #     seconds: 0
  #   )
  # end

  # @working_seconds 1500
  # defp put_timer(
  #        %{
  #          assigns: %{
  #            current_pomodoro: current_pomodoro,
  #            mode: :active,
  #            elapsed: @working_seconds
  #          }
  #        } = socket
  #      ) do
  #   finished_pomodoro_count = current_pomodoro + 1

  #   break_mode =
  #     case rem(finished_pomodoro_count, 4) do
  #       0 -> :long_break
  #       _ -> :break
  #     end

  #   assign(socket,
  #     mode: break_mode,
  #     elapsed: 0,
  #     seconds: 0,
  #     current_pomodoro: finished_pomodoro_count
  #   )
  # end

  # @break_seconds 300
  # defp put_timer(%{assigns: %{mode: :break, elapsed: @break_seconds}} = socket),
  #   do: activate(socket)

  # @long_break_seconds 900
  # defp put_timer(%{assigns: %{mode: :long_break, elapsed: @long_break_seconds}} = socket),
  #   do: activate(socket)

  # defp put_timer(%{assigns: %{elapsed: 0}} = socket) do
  #   socket
  #   |> assign_timer_val()
  #   |> assign(notification_id: Ecto.UUID.generate())
  # end

  # defp put_timer(socket) do
  #   assign_timer_val(socket)
  # end

  # defp assign_timer_val(socket) do
  #   %{assigns: %{elapsed: elapsed, mode: mode}} = socket

  #   mode_seconds = get_mode_seconds(mode)

  #   minutes = div(mode_seconds - elapsed, 60)
  #   seconds = rem(mode_seconds - elapsed, 60)

  #   assign(socket, elapsed: elapsed + 1, minutes: minutes, seconds: seconds)
  # end


  # defp get_mode_seconds(:active), do: @working_seconds
  # defp get_mode_seconds(:break), do: @break_seconds
  # defp get_mode_seconds(:long_break), do: @long_break_seconds

end