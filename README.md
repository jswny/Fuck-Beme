# FuckBeme

Beme is a terrible app which is a shitty rip off of Snapchat. It does everything that Snapchat does, but worse. So, I made this Twitter bot to let the world know how much I hate Beme.

## Components
- `DETS` for persistent storage
- `erlang-oauth` for OAuth with the Twitter API
- `extwitter` for interacting with the Twitter API

## Test environment
- CentOS 7
- Elixir 1.3.0
- Erlang/OTP 18
- ExTwitter 0.7.1

## Setup
1. Clone this repo: `git clone https://github.com/jswny/fuck-beme`
2. Fill in `config/config.exs` with your Twitter API information which can be obtained from http://apps.twitter.com/
3. In the directory of this repository, start **mix** in IEx (the Elixir Repl): `iex -S mix`
4. Initialize the local DETS store: `FuckBeme.init()`
  - This will create a binary file named `replied_to` which contains the DETS store
5. Run `FuckBeme.search_and_reply()` and let the tweets fly!
  - You may optionally supply an argument for this function like `FuckBeme.search_and_reply(10)` if you want to search 10 tweets only

## Warning
**Use this Twitter bot at your own risk!** If you use this bot, it is likely that your Twitter API access will be suspended because Twitter considers this kind of auto-reply bot spam. In addition, your Twitter account may be suspended if you run this bot. This is meant to be a fun project to experiment with Elixir, not a production Twitter application.

## Note
Yes, I know there are API keys in the commit history. No, they do not work. Yes, all of those API keys got banned within a few minutes for using this bot.

