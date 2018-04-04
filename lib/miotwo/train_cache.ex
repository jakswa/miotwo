
defmodule Miotwo.TrainCache do
  use GenServer
  @vars %{url: "http://developer.itsmarta.com/RealtimeTrain/RestServiceNextTrain/GetRealtimeArrivals?apikey="}

  def train_json do 
    GenServer.call(:train_cache, :train_json)
  end

  def start_link do
    GenServer.start_link(__MODULE__, Timex.now, name: :train_cache) 
  end

  # already expired when created, so HTTP gets triggered
  def init(expires) do 
    {:ok, {expires, nil}}
  end

  def handle_call(:train_json, _from, expires) do
    expires = Timex.diff(Timex.now, elem(expires, 0), :seconds)
    |> check_expires(expires)

    {:reply, elem(expires, 1), expires}
  end

  defp check_expires(diff, {_time, _resp}) when diff > 0 do
    {Timex.shift(Timex.now, seconds: 10), HTTPoison.get(train_url()) }
  end

  defp check_expires(_diff, {time, resp}) do
   {time, resp}
  end

  defp train_url do
    @vars.url <> (System.get_env("MARTA_TRAIN_API_KEY") || "")
  end
end
