defmodule Railway.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false
      add :balance, :decimal, null: false
      add :currency, :string, null: false

      timestamps()
    end
  end
end
