defmodule Railway.Accounts.Data.AccountTest do
  use Railway.DataCase, async: true

  alias Ecto.Changeset
  alias Railway.Accounts.Data.Account

  describe "changeset/2" do
    test "when all attrs is valid, return a valid changeset" do
      valid_attrs = build(:account_attrs)

      valid_account = Account.changeset(valid_attrs)

      assert %Changeset{
               changes: %{
                 currency: "BRL"
               },
               valid?: true
             } = valid_account
    end

    test "when not informed required attributes, returns errors" do
      expected_response = %{
        balance: ["can't be blank"],
        currency: ["can't be blank"]
      }

      invalid_account = Account.changeset(%{})

      assert errors_on(invalid_account) == expected_response
    end

    test "when there is invalid balance, return an error" do
      invalid_attrs = build(:account_attrs, %{"balance" => -10.00})
      expected_response = %{balance: ["must be greater than or equal to 0"]}

      invalid_account = Account.changeset(invalid_attrs)

      assert errors_on(invalid_account) == expected_response
    end
  end
end
