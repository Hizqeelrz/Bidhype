defmodule Bidhype.Auth do
  import Plug.Conn
  import Phoenix.Controller

  alias Bidhype.Accounts

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    if user_id = Plug.Conn.get_session(conn, :current_user_id) do
      current_user = Accounts.get_user!(user_id)
      conn
      |> assign(:current_user_id, current_user)
    else
      conn
      |> redirect(to: "/login")
      |> halt()
    end
  end
  
  def signed_in?(conn) do
    user_id = Plug.Conn.get_session(conn, :current_user_id)
    if user_id, do: !!Bidhype.Repo.get(Bidhype.Accounts.User, user_id)
  end

end