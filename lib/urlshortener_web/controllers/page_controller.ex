defmodule UrlshortenerWeb.PageController do
  use UrlshortenerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
