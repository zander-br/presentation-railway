defmodule Railway.Accounts.Data.Account do
  use Ecto.Schema

  import Ecto.Changeset

  @fields [:balance, :currency]
  @required_fields [:balance, :currency]

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "accounts" do
    field :balance, :decimal
    field :currency, :string

    timestamps()
  end

  def changeset(attrs \\ %{}) do
    changeset(%__MODULE__{}, attrs)
  end

  def changeset(transfer, attrs) do
    transfer
    |> cast(attrs, @fields)
    |> validate_required(@required_fields)
    |> validate_number(:balance, greater_than_or_equal_to: 0)
  end
end
