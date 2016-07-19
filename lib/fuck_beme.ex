defmodule FuckBeme do
  def reply(tweet) when tweet.user.screen_name != "" do
    ExTwitter.update("@" <> tweet.user.screen_name <> " Fuck Beme", in_reply_to_status_id: tweet.id)
  end

  def search_and_reply() do
    ExTwitter.search("beme", [count: 3]) 
      |> Enum.each(&(reply(&1)))
  end
end
