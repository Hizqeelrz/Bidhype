defmodule BidhypeWeb.PageController do
  use BidhypeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
