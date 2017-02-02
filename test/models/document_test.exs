defmodule XdocApi.DocumentTest do
  use XdocApi.ModelCase

  alias XdocApi.Document

  @valid_attrs %{rendered_text: "some content", text: "some content", title: "some content", user_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Document.changeset(%Document{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Document.changeset(%Document{}, @invalid_attrs)
    refute changeset.valid?
  end
end
