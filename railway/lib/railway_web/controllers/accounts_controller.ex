defmodule RailwayWeb.AccountsController do
  use RailwayWeb, :controller

  alias Railway.Accounts.Core.CreateAccount
  alias Railway.Accounts.Data.Account
  alias RailwayWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %Account{} = account} <- CreateAccount.execute(params) do
      conn
      |> put_status(:created)
      |> render("create.json", account: account)
    end
  end
end
