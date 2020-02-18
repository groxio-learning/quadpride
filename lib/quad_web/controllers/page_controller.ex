defmodule QuadWeb.PageController do
  use QuadWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
