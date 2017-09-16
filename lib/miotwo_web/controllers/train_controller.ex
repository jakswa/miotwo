defmodule MiotwoWeb.TrainController do
  use MiotwoWeb, :controller
  alias Miotwo.TrainCache

  def index(conn, %{}) do
    resp = TrainCache.train_json
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(resp.status_code, resp.body)
  end
end