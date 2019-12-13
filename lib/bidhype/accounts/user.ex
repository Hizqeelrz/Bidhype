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

    # Virtual Field
    field :password, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email, :password, :avatar, :gender, :mobile])
    |> validate_required([:first_name, :email, :password])
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    pass = Argon2.add_hash(password)

    put_change(changeset, :password_hash, pass.password_hash)
  end

  defp put_pass_hash(changeset), do: changeset
end
