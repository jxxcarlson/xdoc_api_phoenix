defmodule XdocApi.DocumentView do
  use XdocApi.Web, :view

  def render("index.json", %{documents: documents}) do
    %{data: render_many(documents, XdocApi.DocumentView, "document_summary.json")}
  end

  def render("show.json", %{document: document}) do
    %{data: render_one(document, XdocApi.DocumentView, "document.json")}
  end

  def render("document.json", %{document: document}) do
    %{id: document.id,
      title: document.title,
      rendered_text: document.rendered_text,
      author_id: document.author_id}
  end

    def render("editable_document.json", %{document: document}) do
    %{id: document.id,
      title: document.title,
      text: document.text,
      rendered_text: document.rendered_text,
      author_id: document.author_id}
  end

  def render("document_summary.json", %{document: document}) do
    %{id: document.id,
      title: document.title,
      }
  end

end
