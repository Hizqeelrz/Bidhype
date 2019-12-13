defmodule Bidhype.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :avatar, :string
    field :email, :string
    field :first_name, :string
    field :gender, :integer
    field :last_name, :string
    field :mobile, :string
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email, :password_hash, :avatar, :gender, :mobile])
    |> validate_required([:first_name, :last_name, :email, :password_hash, :avatar, :gender, :mobile])
  end
end
