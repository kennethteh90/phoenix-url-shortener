defmodule Urlshortener.Links.Link do
  use Ecto.Schema
  import Ecto.Changeset
  alias Urlshortener.Links.Link


  schema "links" do
    field :fullurl, :string
    field :shorturl, :string

    timestamps()
  end

  @doc false
  def changeset(%Link{} = link, attrs) do
    link
    |> cast(attrs, [:shorturl, :fullurl])
    |> validate_required([:shorturl, :fullurl])
  end
end
