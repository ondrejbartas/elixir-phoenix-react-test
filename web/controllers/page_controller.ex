defmodule Questhor.PageController do
  use Questhor.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
