defmodule Urlshortener.Links do
  @moduledoc """
  The Links context.
  """

  import Ecto.Query, warn: false
  alias Urlshortener.Repo
  alias Urlshortener.Links.Link

  @doc """
  Returns the list of links.

  ## Examples

      iex> list_links()
      [%Link{}, ...]

  """
  def list_links do
    Link
    |> order_by([l], desc: l.inserted_at)
    |> Repo.all()
  end

  @doc """
  Gets a single link.

  Raises `Ecto.NoResultsError` if the Link does not exist.

  ## Examples

      iex> get_link!(123)
      %Link{}

      iex> get_link!(456)
      ** (Ecto.NoResultsError)

  """
  def get_link!(id), do: Repo.get!(Link, id)

  @doc """
  Gets a link by short code.

  Returns `nil` if the Link does not exist.

  ## Examples

      iex> get_link_by_short_code("abc123")
      %Link{}

      iex> get_link_by_short_code("nonexistent")
      nil

  """
  def get_link_by_short_code(short_code) do
    Link
    |> where([l], l.short_code == ^short_code)
    |> Repo.one()
  end

  @doc """
  Creates a link.

  ## Examples

      iex> create_link(%{field: value})
      {:ok, %Link{}}

      iex> create_link(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_link(attrs \\ %{}) do
    attrs = Map.put_new(attrs, :short_code, Link.generate_short_code())
    
    %Link{}
    |> Link.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a link.

  ## Examples

      iex> update_link(link, %{field: new_value})
      {:ok, %Link{}}

      iex> update_link(link, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_link(%Link{} = link, attrs) do
    link
    |> Link.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Increments the click count for a link.

  ## Examples

      iex> increment_clicks(link)
      {:ok, %Link{}}

  """
  def increment_clicks(%Link{} = link) do
    link
    |> Ecto.Changeset.change(clicks: link.clicks + 1)
    |> Repo.update()
  end

  @doc """
  Deletes a Link.

  ## Examples

      iex> delete_link(link)
      {:ok, %Link{}}

      iex> delete_link(link)
      {:error, %Ecto.Changeset{}}

  """
  def delete_link(%Link{} = link) do
    Repo.delete(link)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking link changes.

  ## Examples

      iex> change_link(link)
      %Ecto.Changeset{source: %Link{}}

  """
  def change_link(%Link{} = link) do
    Link.changeset(link, %{})
  end

  @doc """
  Returns the most popular links by click count.

  ## Examples

      iex> get_popular_links(10)
      [%Link{}, ...]

  """
  def get_popular_links(limit \\ 10) do
    Link
    |> order_by([l], desc: l.clicks)
    |> limit(^limit)
    |> Repo.all()
  end
end
