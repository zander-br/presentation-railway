defmodule Railway.Transactions.Core.TransactionRepo do
  alias Railway.Repo
  alias Railway.Transactions.Data.Transaction

  def create_transaction(transaction) do
    transaction
    |> Transaction.changeset()
    |> Repo.insert()
  end
end
