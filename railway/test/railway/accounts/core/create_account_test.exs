defmodule Railway.Accounts.Core.CreateAccountTest do
  use Railway.DataCase, async: true

  alias Ecto.Changeset
  alias Railway.Accounts.Core.CreateAccount
  alias Railway.Accounts.Data.Account

  describe "execute/1" do
    test "when all params is valid, returns the account" do
      valid_account = build(:account_attrs)

      response = CreateAccount.execute(valid_account)

      assert {:ok, %Account{id: _id, inserted_at: _inserted_at, currency: "BRL"}} = response
    end

    test "when there is invalid params, returns an error" do
      invalid_account = build(:account_attrs, %{"balance" => -10.00})
      expected_response = %{balance: ["must be greater than or equal to 0"]}

      response = CreateAccount.execute(invalid_account)

      assert {:error, {:unprocessable_entity, %Changeset{valid?: false} = changeset}} = response
      assert errors_on(changeset) == expected_response
    end
  end
end
