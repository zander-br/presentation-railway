defmodule Railway.Transactions.Core.AddWithdraw do
  alias Railway.Accounts.Core.AccountRepo
  alias Railway.Transactions.Core.TransactionRepo

  def execute(transaction) do
    transaction
    |> get_account()
    |> add_transaction_type()
    |> create_transaction()
    |> update_account_balance()
  end

  defp get_account(%{"account_id" => account_id} = transaction) do
    case AccountRepo.get_by_id(account_id) do
      nil -> {:error, {:not_found, "account not found"}}
      account -> {:ok, %{transaction: transaction, account: account}}
    end
  end

  defp add_transaction_type({:ok, %{transaction: transaction, account: account}}) do
    transaction = Map.put(transaction, "type", :withdraw)
    {:ok, %{transaction: transaction, account: account}}
  end

  defp add_transaction_type({:error, _opts} = error), do: error

  defp create_transaction({:ok, %{transaction: transaction, account: account}}) do
    case TransactionRepo.create_transaction(transaction) do
      {:error, changeset} -> {:error, {:unprocessable_entity, changeset}}
      {:ok, transaction} -> {:ok, %{transaction: transaction, account: account}}
    end
  end

  defp create_transaction({:error, _opts} = error), do: error

  defp update_account_balance({:ok, %{transaction: transaction, account: account}}) do
    current_balance = Decimal.sub(account.balance, transaction.amount)

    case(AccountRepo.update_account(account, %{balance: current_balance})) do
      {:error, changeset} -> {:error, {:unprocessable_entity, changeset}}
      {:ok, _account} -> {:ok, transaction}
    end
  end

  defp update_account_balance({:error, _opts} = error), do: error
end
