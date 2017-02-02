defmodule XdocApi.PageController do
  use XdocApi.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
