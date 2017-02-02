defmodule XdocApi.DocumentControllerTest do
  use XdocApi.ConnCase

  alias XdocApi.Document
  @valid_attrs %{rendered_text: "some content", text: "some content", title: "some content", user_id: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, document_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    document = Repo.insert! %Document{}
    conn = get conn, document_path(conn, :show, document)
    assert json_response(conn, 200)["data"] == %{"id" => document.id,
      "title" => document.title,
      "text" => document.text,
      "rendered_text" => document.rendered_text,
      "user_id" => document.user_id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, document_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, document_path(conn, :create), document: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Document, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, document_path(conn, :create), document: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    document = Repo.insert! %Document{}
    conn = put conn, document_path(conn, :update, document), document: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Document, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    document = Repo.insert! %Document{}
    conn = put conn, document_path(conn, :update, document), document: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    document = Repo.insert! %Document{}
    conn = delete conn, document_path(conn, :delete, document)
    assert response(conn, 204)
    refute Repo.get(Document, document.id)
  end
end
