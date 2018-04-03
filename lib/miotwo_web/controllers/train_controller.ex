defmodule MiotwoWeb.TrainController do
  use MiotwoWeb, :controller
  alias Miotwo.TrainCache

  # Proxy the raw response from MARTA,
  # including content-type, status, and body.
  def index(conn, %{}) do
    resp = train_json()
    content_type = Enum.find(resp.headers, fn(i) -> 
      elem(i, 0) == "Content-Type"
    end) |> elem(1)

    conn
    |> put_resp_content_type(content_type)
    |> send_resp(resp.status_code, resp.body)
  end


  defp train_json do
    TrainCache.train_json
  end
end
