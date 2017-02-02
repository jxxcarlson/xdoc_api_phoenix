defmodule XdocApi.DocumentController do
  use XdocApi.Web, :controller

  alias XdocApi.Document
  alias XdocApi.Search

  # API:
  # GET documents?title=foo        -- return documents whose title contains 'foo'
  # GET documents                  -- return all documents
  # GET documents/33               -- return document with id = 33
  # GET documents/new              -- create new document
  # POST documents                 -- create new document with given title, author_id, text,
  #                                   and rendered text
  # PUT documents/33               -- update document with id 33
  # DELETE documents/33            -- delete document with id 33
  # (+) DELETE documents/33?mode=soft  -- make document 33 invisible

  # "documents?title=foo" => documents whose title contains "foo"
  def index(conn, %{"title" => title} = params) do
    documents = Search.simple_title_search(title)
    render(conn, "index.json", documents: documents)
  end

  def index(conn, _params) do
    documents = Repo.all(Document)
    render(conn, "index.json", documents: documents)
  end

  def create(conn, %{"document" => document_params}) do
    document_params = Map.merge(document_params, Document.initial_parameters())
    changeset = Document.changeset(%Document{}, document_params)
    IO.inspect document_params
    case Repo.insert(changeset) do
      {:ok, document} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", document_path(conn, :show, document))
        |> render("show.json", document: document)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(XdocApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    document = Repo.get!(Document, id)
    render(conn, "show.json", document: document)
  end

  def update(conn, %{"id" => id, "document" => document_params}) do
    document = Repo.get!(Document, id)
    IO.puts "UPDATE, ID = #{document.id}"
    changeset = Document.update_changeset(document, document_params)

    case Repo.update(changeset) do
      {:ok, document} ->
        render(conn, "show.json", document: document)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(XdocApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    document = Repo.get!(Document, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(document)

    send_resp(conn, :no_content, "")
  end
end
