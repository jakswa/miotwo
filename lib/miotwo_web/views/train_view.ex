defmodule MiotwoWeb.TrainView do
  use MiotwoWeb, :view
  alias Miotwo.TrainCache

  def render("index.json", %{}) do
    # TrainCache.train_json.body
  end
end