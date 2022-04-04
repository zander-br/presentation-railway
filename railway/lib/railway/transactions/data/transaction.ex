defmodule Railway.Transactions.Data.Transaction do
  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Enum
  alias Railway.Accounts.Data.Account

  @fields [:amount, :type, :account_id]
  @required_fields [:amount, :type, :account_id]
  @transaction_type [:withdraw, :deposit]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "transactions" do
    field :amount, :decimal
    field :type, Enum, values: @transaction_type

    belongs_to :account, Account

    timestamps()
  end

  def changeset(attrs \\ %{}) do
    changeset(%__MODULE__{}, attrs)
  end

  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, @fields)
    |> validate_required(@required_fields)
    |> validate_number(:amount, greater_than: 0)
  end
end
