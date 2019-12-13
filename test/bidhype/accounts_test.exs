defmodule Bidhype.AccountsTest do
  use Bidhype.DataCase

  alias Bidhype.Accounts

  describe "users" do
    alias Bidhype.Accounts.User

    @valid_attrs %{avatar: "some avatar", email: "some email", first_name: "some first_name", gender: 42, last_name: "some last_name", mobile: "some mobile", password_hash: "some password_hash"}
    @update_attrs %{avatar: "some updated avatar", email: "some updated email", first_name: "some updated first_name", gender: 43, last_name: "some updated last_name", mobile: "some updated mobile", password_hash: "some updated password_hash"}
    @invalid_attrs %{avatar: nil, email: nil, first_name: nil, gender: nil, last_name: nil, mobile: nil, password_hash: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.avatar == "some avatar"
      assert user.email == "some email"
      assert user.first_name == "some first_name"
      assert user.gender == 42
      assert user.last_name == "some last_name"
      assert user.mobile == "some mobile"
      assert user.password_hash == "some password_hash"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.avatar == "some updated avatar"
      assert user.email == "some updated email"
      assert user.first_name == "some updated first_name"
      assert user.gender == 43
      assert user.last_name == "some updated last_name"
      assert user.mobile == "some updated mobile"
      assert user.password_hash == "some updated password_hash"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
