defmodule PhoenixCharges.PageController do
  use PhoenixCharges.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
