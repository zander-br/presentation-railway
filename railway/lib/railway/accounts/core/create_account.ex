defmodule Railway.Accounts.Core.CreateAccount do
  alias Railway.Accounts.Core.AccountRepo

  def execute(account) do
    case AccountRepo.create_account(account) do
      {:ok, account} -> {:ok, account}
      {:error, changeset} -> {:error, {:unprocessable_entity, changeset}}
    end
  end
end
