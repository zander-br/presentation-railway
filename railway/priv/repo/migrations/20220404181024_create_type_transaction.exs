defmodule Railway.Repo.Migrations.CreateTypeTransaction do
  use Ecto.Migration

  def change do
    up_query = "CREATE TYPE transaction_type AS ENUM ('withdraw', 'deposit')"

    down_query = "DROP TYPE transaction_type"

    execute(up_query, down_query)
  end
end
