defmodule MarkdownWeb.PageController do
  use MarkdownWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
