defmodule UrlshortenerWeb.Router do
  use UrlshortenerWeb, :router

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

  scope "/", UrlshortenerWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/links", LinkController
    get "/bitly/:messenger", ShortController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", UrlshortenerWeb do
  #   pipe_through :api
  # end
end
