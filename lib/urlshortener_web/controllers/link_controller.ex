defmodule UrlshortenerWeb.LinkController do
  use UrlshortenerWeb, :controller

  alias Urlshortener.Links
  alias Urlshortener.Links.Link

  def index(conn, _params) do
    links = Links.list_links()
    render(conn, "index.html", links: links)
  end

  def new(conn, _params) do
    changeset = Links.change_link(%Link{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"link" => link_params}) do
    case Links.create_link(link_params) do
      {:ok, link} ->
        conn
        |> put_flash(:info, "Link created successfully. Your shortened link is  #{link_url(conn, :show, link)}" )
        # |> redirect(to: link_path(conn, :show, link))
        |> redirect(to: link_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    link = Links.get_link!(id)
    # render(conn, "show.html", link: link)
    redirect conn, external: link.fullurl
  end

  def edit(conn, %{"id" => id}) do
    link = Links.get_link!(id)
    changeset = Links.change_link(link)
    render(conn, "edit.html", link: link, changeset: changeset)
  end

  def update(conn, %{"id" => id, "link" => link_params}) do
    link = Links.get_link!(id)

    case Links.update_link(link, link_params) do
      {:ok, link} ->
        conn
        |> put_flash(:info, "Link updated successfully.")
        |> redirect(to: link_path(conn, :show, link))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", link: link, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    link = Links.get_link!(id)
    {:ok, _link} = Links.delete_link(link)

    conn
    |> put_flash(:info, "Link deleted successfully.")
    |> redirect(to: link_path(conn, :index))
  end
end
