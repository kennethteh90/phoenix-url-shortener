defmodule Urlshortener.LinksTest do
  use Urlshortener.DataCase

  alias Urlshortener.Links

  describe "links" do
    alias Urlshortener.Links.Link

    @valid_attrs %{fullurl: "some fullurl", shorturl: "some shorturl"}
    @update_attrs %{fullurl: "some updated fullurl", shorturl: "some updated shorturl"}
    @invalid_attrs %{fullurl: nil, shorturl: nil}

    def link_fixture(attrs \\ %{}) do
      {:ok, link} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Links.create_link()

      link
    end

    test "list_links/0 returns all links" do
      link = link_fixture()
      assert Links.list_links() == [link]
    end

    test "get_link!/1 returns the link with given id" do
      link = link_fixture()
      assert Links.get_link!(link.id) == link
    end

    test "create_link/1 with valid data creates a link" do
      assert {:ok, %Link{} = link} = Links.create_link(@valid_attrs)
      assert link.fullurl == "some fullurl"
      assert link.shorturl == "some shorturl"
    end

    test "create_link/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Links.create_link(@invalid_attrs)
    end

    test "update_link/2 with valid data updates the link" do
      link = link_fixture()
      assert {:ok, link} = Links.update_link(link, @update_attrs)
      assert %Link{} = link
      assert link.fullurl == "some updated fullurl"
      assert link.shorturl == "some updated shorturl"
    end

    test "update_link/2 with invalid data returns error changeset" do
      link = link_fixture()
      assert {:error, %Ecto.Changeset{}} = Links.update_link(link, @invalid_attrs)
      assert link == Links.get_link!(link.id)
    end

    test "delete_link/1 deletes the link" do
      link = link_fixture()
      assert {:ok, %Link{}} = Links.delete_link(link)
      assert_raise Ecto.NoResultsError, fn -> Links.get_link!(link.id) end
    end

    test "change_link/1 returns a link changeset" do
      link = link_fixture()
      assert %Ecto.Changeset{} = Links.change_link(link)
    end
  end
end
