defmodule Miotwo.TrainCacheTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    HTTPoison.start
  end

  describe "handle_call" do
    test "gives cache when not expired (no HTTP)" do
      expires = Timex.shift(Timex.now, minutes: 10)
      assert {:reply, :cached_value, result} =
        Miotwo.TrainCache.handle_call(:train_json, nil, {expires, :cached_value})

      assert expires == elem(result, 0)
    end

    test "hits API when expired" do
      use_cassette "marta_api" do
        expires = Timex.shift(Timex.now, minutes: -10)
        assert {:reply, resp, result} =
          Miotwo.TrainCache.handle_call(:train_json, nil, {expires, :cached_value})

        assert expires != elem(result, 0)
        assert resp != :cached_value
        assert elem(resp, 0) == :ok
      end
    end

    test "subsequent hits return same result" do
      use_cassette "marta_api" do
        expires = Timex.shift(Timex.now, minutes: -10)
        resp = Miotwo.TrainCache.handle_call(:train_json, nil, {expires, :cached_value})

        assert resp == Miotwo.TrainCache.handle_call(:train_json, nil, elem(resp, 2))
      end
    end
  end

  describe "train_json" do
    test "hits API" do
      use_cassette "marta_api" do
        assert {:ok, _resp} = Miotwo.TrainCache.train_json
      end
    end

    test "quickly repeated calls are equal" do
      use_cassette "marta_api" do
        assert Miotwo.TrainCache.train_json ==
          Miotwo.TrainCache.train_json
      end
    end
  end
end
