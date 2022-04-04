defmodule Railway.Transfers.Core.GetTransfer do
  alias Railway.Accounts.Core.AccountRepo

  def by_id(id) do
    case AccountRepo.get_by_id(id) do
      nil -> {:error, {:not_found, "account not found"}}
      account -> {:ok, account}
    end
  end
end
