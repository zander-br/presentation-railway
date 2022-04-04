defmodule RailwayWeb.AccountsView do
  use RailwayWeb, :view

  alias Railway.Accounts.Data.Account

  def render("create.json", %{account: %Account{} = account}) do
    %{
      id: account.id,
      balance: account.balance,
      currency: account.currency
    }
  end
end
