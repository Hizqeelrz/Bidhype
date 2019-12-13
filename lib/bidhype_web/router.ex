defmodule BidhypeWeb.Router do
  use BidhypeWeb, :router

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

  scope "/", BidhypeWeb do
    pipe_through :browser

    get "/", PageController, :index
    
    get "/sign-in", SessionController, :new
    post "/sign-in", SessionController, :create
    delete "sign-out", SessionController, :delete


    resources "/registration", UserController, only: [:new, :create, :show]
    resources "/bids", BidController

  end

  # Other scopes may use custom stacks.
  # scope "/api", BidhypeWeb do
  #   pipe_through :api
  # end
end
