defmodule PhoenixCharges.Router do
  use PhoenixCharges.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhoenixCharges do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", PhoenixCharges do
    pipe_through :api

    resources "/cards", CardController, only: [:create]
    resources "/charges", ChargeController, only: [:show, :create]

  end
end
