defmodule FuckBeme do
  defp reply(username, tweet_id) do
    ExTwitter.update("@" <> username <> " Fuck Beme", in_reply_to_status_id: tweet_id)
    insert_id(tweet_id)
  end

  defp process_tweet(%{:id => tweet_id, :user => %{:screen_name => username}, :text => tweet_text, :retweeted_status => nil}) do
    if (!tweet_contains_beme(tweet_text)) do
      IO.puts "Skipping reply to " <> username <> " - Tweet not about Beme"
    else
      if replied_to?(tweet_id) do
        IO.puts "Skipping reply to " <> username <> " - Already replied"
      else
        IO.puts "Replying to " <> username
        reply(username, tweet_id)
      end
    end
  end
  defp process_tweet(%{:user => %{:screen_name => username}}) do
    IO.puts "Skipping reply to " <> username <> " - Retweet"
  end

  defp tweet_contains_beme(tweet_text) do
    tweet_text
      |> String.split(" ", trim: true)
      |> Enum.map(&map_tweet_text/1)
      |> Enum.any?(&String.downcase(&1) |> String.contains?("beme"))
  end

  defp map_tweet_text(chunk) do
    if String.starts_with?(chunk, "@") do
      ""
    else
      chunk
    end
  end

  defp insert_id(id) do
    :dets.insert(:replied_to, {id, self})
  end

  defp replied_to?(id) do
    case :dets.lookup(:replied_to, id) do
      [{_, _}] -> true
      [] -> false
    end
  end

  def init() do
    :dets.open_file(:replied_to, [type: :set])
  end

  def close() do
    :dets.close(:replied_to)
  end

  def search_and_reply(num_tweets \\ 100) do
    ExTwitter.search("beme", count: num_tweets) 
      |> Enum.each(&process_tweet/1)
  end
end
