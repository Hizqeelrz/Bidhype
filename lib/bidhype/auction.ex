defmodule Bidhype.Auction do
  @moduledoc """
  The Auction context.
  """

  import Ecto.Query, warn: false
  alias Bidhype.Repo

  alias Bidhype.Auction.Bid

  @topic inspect(__MODULE__)

  def subscribe do
    Phoenix.PubSub.subscribe(Bidhype.PubSub, @topic)
  end

  @doc """
  Returns the list of bids.

  ## Examples

      iex> list_bids()
      [%Bid{}, ...]

  """
  def list_bids do
    Repo.all(Bid)
  end

  @doc """
  Gets a single bid.

  Raises `Ecto.NoResultsError` if the Bid does not exist.

  ## Examples

      iex> get_bid!(123)
      %Bid{}

      iex> get_bid!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bid!(id), do: Repo.get!(Bid, id)

  @doc """
  Creates a bid.

  ## Examples

      iex> create_bid(%{field: value})
      {:ok, %Bid{}}

      iex> create_bid(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bid(attrs \\ %{}) do
    %Bid{}
    |> Bid.changeset(attrs)
    |> Repo.insert()
    |> notify_subscribers([:bid, :created])
  end

  @doc """
  Updates a bid.

  ## Examples

      iex> update_bid(bid, %{field: new_value})
      {:ok, %Bid{}}

      iex> update_bid(bid, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bid(%Bid{} = bid, attrs) do
    bid
    |> Bid.changeset(attrs)
    |> Repo.update()
    |> notify_subscribers([:bid, :updated])
  end

  @doc """
  Deletes a Bid.

  ## Examples

      iex> delete_bid(bid)
      {:ok, %Bid{}}

      iex> delete_bid(bid)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bid(%Bid{} = bid) do
    Repo.delete(bid)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bid changes.

  ## Examples

      iex> change_bid(bid)
      %Ecto.Changeset{source: %Bid{}}

  """
  def change_bid(%Bid{} = bid) do
    Bid.changeset(bid, %{})
  end

  def save_avatar(file, schema) do
    case file do
      "" -> "https://www.fantraxhq.com/wp-content/uploads/2019/06/Fantasy-Football-Auction-Draft-Strategy.jpg"
      nil -> "https://www.fantraxhq.com/wp-content/uploads/2019/06/Fantasy-Football-Auction-Draft-Strategy.jpg"
      _ ->
        {:ok, _file} = Bidhype.Avatar.store({file, schema})
        url = Bidhype.Avatar.url({schema.id, schema}, :original)
        url
    end
  end

  # render the change live 
  defp notify_subscribers({:ok, result}, event) do
    Phoenix.PubSub.broadcast(Bidhype.PubSub, @topic, {__MODULE__, event, result})
    {:ok, result}
  end

  defp notify_subscribers({:error, reason}, _event) do
    {:error, reason}
  end
end
