defmodule Railway.Transactions.Data.TransactionTest do
  use Railway.DataCase, async: true

  alias Ecto.Changeset
  alias Railway.Transactions.Data.Transaction

  describe "changeset/2" do
    test "when all attrs is valid, return a valid changeset" do
      valid_attrs = build(:transaction_attrs)

      valid_transaction = Transaction.changeset(valid_attrs)

      assert %Changeset{
               changes: %{
                 type: :deposit,
                 account_id: "ffaa0f75-ede9-4921-81a5-0f898901023d"
               },
               valid?: true
             } = valid_transaction
    end

    test "when not informed required attributes, returns errors" do
      expected_response = %{
        account_id: ["can't be blank"],
        type: ["can't be blank"],
        amount: ["can't be blank"]
      }

      invalid_transaction = Transaction.changeset(%{})

      assert errors_on(invalid_transaction) == expected_response
    end

    test "when there is invalid balance, return an error" do
      invalid_attrs = build(:transaction_attrs, %{"amount" => 0})
      expected_response = %{amount: ["must be greater than 0"]}

      invalid_transaction = Transaction.changeset(invalid_attrs)

      assert errors_on(invalid_transaction) == expected_response
    end
  end
end
