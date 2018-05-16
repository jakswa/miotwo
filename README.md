# Miotwo [![build status](https://travis-ci.org/jakswa/miotwo.svg?branch=master)](https://travis-ci.org/jakswa/miotwo)

A rewrite of jakswa/marta_api in Phoenix/Elixir. Strangely enough, you have to get far enough into Elixir to where you understand OTP a little bit, before you can write a "globally shared 10s request cache," as implemented in jakswa/marta_api.

`Miotwo.TrainCache` is a GenServer that is started with the app. It has logic to fetch new JSON when 10s has passed. Concurrent requests will do `TrainCache.train_json`, which results in the GenServer synchronously processing each call (in order?). It's neat now that I understand it, but feels pretty overbuilt for a "cached HTTP proxy".

## development

To get a working Marta Train response:

  * Install dependencies with `mix deps.get`
  * Set the `MARTA_TRAIN_API_KEY` ENV variable to your key.
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000/api/trains`](http://localhost:4000/api/trains) from your browser.

## sponsors

![scout_dog](https://apm.scoutapp.com/assets/public/orange_logo-8fb7805c7eb95e306efe263dbe27994bfcf3610e0bb5a879f626448889e00515.png)
