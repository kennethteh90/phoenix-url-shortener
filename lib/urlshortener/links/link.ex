defmodule Urlshortener.Links.Link do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "links" do
    field :original_url, :string
    field :short_code, :string
    field :clicks, :integer, default: 0
    field :title, :string
    field :description, :string

    timestamps()
  end

  @doc false
  def changeset(%Link{} = link, attrs) do
    link
    |> cast(attrs, [:original_url, :short_code, :clicks, :title, :description])
    |> validate_required([:original_url, :short_code])
    |> validate_url(:original_url)
    |> validate_short_code(:short_code)
    |> unique_constraint(:short_code)
    |> unique_constraint(:original_url)
  end

  defp validate_url(changeset, field) do
    validate_change(changeset, field, fn _, url ->
      cond do
        is_nil(url) or url == "" ->
          [{"URL cannot be empty", []}]
        not String.starts_with?(url, ["http://", "https://"]) ->
          [{"URL must start with http:// or https://", []}]
        true ->
          []
      end
    end)
  end

  defp validate_short_code(changeset, field) do
    validate_change(changeset, field, fn _, short_code ->
      cond do
        is_nil(short_code) or short_code == "" ->
          [{"Short code cannot be empty", []}]
        String.length(short_code) < 3 ->
          [{"Short code must be at least 3 characters long", []}]
        String.length(short_code) > 20 ->
          [{"Short code must be at most 20 characters long", []}]
        not String.match?(short_code, ~r/^[a-zA-Z0-9_-]+$/) ->
          [{"Short code can only contain letters, numbers, hyphens, and underscores", []}]
        true ->
          []
      end
    end)
  end

  def generate_short_code do
    :crypto.strong_rand_bytes(6)
    |> Base.url_encode64()
    |> binary_part(0, 8)
    |> String.downcase()
    |> String.replace(~r/[^a-z0-9]/, "")
  end
end
