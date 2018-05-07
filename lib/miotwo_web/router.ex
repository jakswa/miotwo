defmodule MiotwoWeb.Router do
  use MiotwoWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MiotwoWeb do
    pipe_through :api

    get "/trains", TrainController, :index
  end

  defp handle_errors(conn, %{kind: kind, reason: reason, stack: stacktrace}) do
    Rollbax.report(kind, reason, stacktrace)
  end
end
