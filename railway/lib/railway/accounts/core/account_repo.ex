defmodule Railway.Accounts.Core.AccountRepo do
  alias Railway.Repo
  alias Railway.Accounts.Data.Account

  def create_account(account) do
    account
    |> Account.changeset()
    |> Repo.insert()
  end

  def get_by_id(id), do: Repo.get(Account, id)

  def update_account(account, params) do
    account
    |> Account.changeset(params)
    |> Repo.update()
  end
end
