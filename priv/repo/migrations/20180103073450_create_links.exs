defmodule Urlshortener.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :shorturl, :string
      add :fullurl, :string

      timestamps()
    end

  end
end
