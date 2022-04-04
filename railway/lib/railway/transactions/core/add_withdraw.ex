defmodule Railway.Transactions.Core.AddWithdraw do
  alias Railway.Accounts.Core.AccountRepo
  alias Railway.Transactions.Core.TransactionRepo

  def execute(transaction) do
    case AccountRepo.get_by_id(transaction["account_id"]) do
      nil ->
        {:error, {:not_found, "account not found"}}

      account ->
        transaction = Map.put(transaction, "type", :withdraw)

        case TransactionRepo.create_transaction(transaction) do
          {:error, changeset} ->
            {:error, {:unprocessable_entity, changeset}}

          {:ok, transaction} ->
            current_balance = Decimal.sub(account.balance, transaction.amount)

            case(AccountRepo.update_account(account, %{balance: current_balance})) do
              {:error, changeset} -> {:error, {:unprocessable_entity, changeset}}
              {:ok, _account} -> {:ok, transaction}
            end
        end
    end
  end
end
