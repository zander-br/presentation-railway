defmodule RailwayWeb.AccountsControllerTest do
  use RailwayWeb.ConnCase, async: true

  describe "create/2" do
    test "when all params is valid, creates the account", %{conn: conn} do
      params = build(:account_request)

      response =
        conn
        |> post(Routes.accounts_path(conn, :create), params)
        |> json_response(:created)

      assert %{"id" => _id, "currency" => "BRL"} = response
    end

    test "when there is some error in changeset, returns the error", %{conn: conn} do
      params = build(:account_request, %{"balance" => -10.00})

      response =
        conn
        |> post(Routes.accounts_path(conn, :create), params)
        |> json_response(:unprocessable_entity)

      expected_response = %{
        "errors" => [
          %{"field" => "balance", "message" => "must be greater than or equal to 0"}
        ]
      }

      assert expected_response == response
    end
  end
end
