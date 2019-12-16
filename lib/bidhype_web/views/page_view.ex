defmodule BidhypeWeb.PageView do
  use BidhypeWeb, :view
  @img_host Application.get_env(:bidhype, :img_host)

  def url(schema) do
    case schema.avatar do
      "" -> "https://www.fantraxhq.com/wp-content/uploads/2019/06/Fantasy-Football-Auction-Draft-Strategy.jpg"
      nil -> "https://www.fantraxhq.com/wp-content/uploads/2019/06/Fantasy-Football-Auction-Draft-Strategy.jpg"
      _ -> @img_host <> schema.avatar
    end
  end
end
