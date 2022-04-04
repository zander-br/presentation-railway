defmodule RailwayWeb.Router do
  use RailwayWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", RailwayWeb do
    pipe_through :api

    post "/accounts", AccountsController, :create
  end
end
