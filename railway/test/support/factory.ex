defmodule Railway.Factory do
  use ExMachina.Ecto, repo: Railway.Repo

  alias Railway.Accounts.Data.Account

  def account_attrs_factory do
    %{
      "balance" => 100.00,
      "currency" => "BRL"
    }
  end

  def account_request_factory do
    %{
      "balance" => 100.20,
      "currency" => "BRL"
    }
  end

  def account_factory do
    %Account{
      balance: Decimal.new(100),
      currency: "BRL",
      id: "ffaa0f75-ede9-4921-81a5-0f898901023d"
    }
  end

  def transaction_attrs_factory do
    %{
      "amount" => 100.00,
      "type" => :deposit,
      "account_id" => "ffaa0f75-ede9-4921-81a5-0f898901023d"
    }
  end

  def withdraw_request_factory do
    %{
      "amount" => 10.00,
      "account_id" => "ffaa0f75-ede9-4921-81a5-0f898901023d"
    }
  end
end
