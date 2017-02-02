defmodule XdocApi.Router do
  use XdocApi.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    # plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", XdocApi do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/documents", DocumentController, only: [:index, :show, :new, :create, :update, :delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", XdocApi do
  #   pipe_through :api
  # end
end
