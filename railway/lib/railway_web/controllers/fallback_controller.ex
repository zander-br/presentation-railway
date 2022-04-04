defmodule RailwayWeb.FallbackController do
  use RailwayWeb, :controller

  alias Ecto.Changeset
  alias RailwayWeb.ErrorView

  def call(conn, {:error, {status, %Changeset{} = changeset}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", changeset: changeset)
  end

  def call(conn, {:error, {status, error}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", error: error)
  end
end
