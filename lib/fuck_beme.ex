defmodule FuckBeme do
  defp reply(%{:id => tweet_id, :user => %{:screen_name => username}, :text => tweet_text}) do
    if (String.downcase(username) |> String.contains?("beme"))  || check_tweet_text(tweet_text) do
      IO.puts "Skipping reply to " <> username
    else
      IO.puts"Replying to " <> username
      ExTwitter.update("@" <> username <> " Fuck Beme", in_reply_to_status_id: tweet_id)
    end
  end

  defp check_tweet_text(tweet_text) do
    tweet_text
      |> String.split(" ", trim: true)
      |> Enum.any?(&String.starts_with?(&1, "@"))
  end

  def search_and_reply() do
    ExTwitter.search("beme", [count: 10]) 
      |> Enum.each(&reply/1)
  end
end
