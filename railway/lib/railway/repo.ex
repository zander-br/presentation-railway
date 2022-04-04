defmodule Railway.Repo do
  use Ecto.Repo,
    otp_app: :railway,
    adapter: Ecto.Adapters.Postgres
end
