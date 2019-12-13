defmodule Bidhype.Repo do
  use Ecto.Repo,
    otp_app: :bidhype,
    adapter: Ecto.Adapters.Postgres
end
