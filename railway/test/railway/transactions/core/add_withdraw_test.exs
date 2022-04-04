defmodule Railway.Transactions.Core.AddWithdrawTest do
  use Railway.DataCase, async: true

  alias Ecto.Changeset
  alias Railway.Accounts.Core.AccountRepo
  alias Railway.Transactions.Core.AddWithdraw
  alias Railway.Transactions.Data.Transaction

  describe "execute/1" do
    test "when all params is valid, returns the transaction" do
      insert(:account)

      valid_withdraw = build(:withdraw_request)
      expected_balance = Decimal.new("90.0")

      response = AddWithdraw.execute(valid_withdraw)
      account = AccountRepo.get_by_id(valid_withdraw["account_id"])

      assert {:ok, %Transaction{id: _id, inserted_at: _inserted_at, type: :withdraw}} = response
      assert expected_balance == account.balance
    end

    test "when there not exist account, returns an error" do
      insert(:account)

      valid_withdraw =
        build(:withdraw_request, %{"account_id" => "15df97d4-8371-4ce6-9645-10bae3f0a948"})

      response = AddWithdraw.execute(valid_withdraw)

      assert {:error, {:not_found, "account not found"}} = response
    end

    test "when there is invalid params, returns an error" do
      insert(:account)

      invalid_withdraw = build(:withdraw_request, %{"amount" => 0.0})
      expected_response = %{amount: ["must be greater than 0"]}

      response = AddWithdraw.execute(invalid_withdraw)

      assert {:error, {:unprocessable_entity, %Changeset{valid?: false} = changeset}} = response
      assert errors_on(changeset) == expected_response
    end
  end
end
