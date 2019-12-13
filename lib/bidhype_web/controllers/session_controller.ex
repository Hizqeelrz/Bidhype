defmodule BidhypeWeb.SessionController do
  use BidhypeWeb, :controller

  alias Bidhype.Accounts
  alias Bidhype.Accounts.User

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => auth_params}) do
    user = Accounts.get_user_by_email(auth_params["email"])

    case Argon2.check_pass(user, auth_params["password"]) do
      {:ok, user} ->
        conn
        |> put_session(:current_user_id, user.id)
        |> put_flash(:info, "You Signed in successfully")
        |> redirect(to: Routes.user_path(conn, :show, user))
      {:error, _} ->
        conn
        |> put_flash(:error, "Invalid Email or Password! Try again")
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:current_user_id)
    |> put_flash(:success, "Sign Out Successfully")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end