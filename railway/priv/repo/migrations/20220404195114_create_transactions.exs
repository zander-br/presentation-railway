defmodule Railway.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false
      add :amount, :decimal, null: false
      add :type, :transaction_type, null: false
      add :account_id, references(:accounts, type: :binary_id)

      timestamps()
    end
  end
end
