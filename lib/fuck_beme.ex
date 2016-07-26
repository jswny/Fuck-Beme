defmodule FuckBeme do

  # Reply to a specified tweet, making sure to add "@" and the username into the tweet text
  defp reply(username, tweet_id) do
    ExTwitter.update("@" <> username <> " Fuck Beme", in_reply_to_status_id: tweet_id)
    insert_id(tweet_id)
  end

  # Pattern match on the ID, username, tweet contents, and retweeted status
  # Any tweets that are not retweets will match here 
  defp process_tweet(%{:id => tweet_id, :user => %{:screen_name => username}, :text => tweet_text, :retweeted_status => nil}) when username != "FuckBeme" do

    # Do not reply to tweets which do not contain "beme" in the tweet text minus usernames
    if (!tweet_contains_beme(tweet_text)) do
      IO.puts "Skipping reply to " <> username <> " - Tweet not about Beme"
    else

      # Only reply if the tweet has not yet been replied to
      if replied_to?(tweet_id) do
        IO.puts "Skipping reply to " <> username <> " - Already replied"
      else
        IO.puts "Replying to " <> username
        reply(username, tweet_id)
      end
    end
  end

  # Any tweets that are retweets will match here because they will fall through the first function for having a retweeted_status
  defp process_tweet(%{:user => %{:screen_name => username}}) do
    IO.puts "Skipping reply to " <> username <> " - Retweet"
  end

  # Check if a string contains "beme" after stripping away usernames from the text
  defp tweet_contains_beme(tweet_text) do
    tweet_text
      |> String.split(" ", trim: true)
      |> Enum.map(&map_tweet_text/1)
      |> Enum.any?(&String.downcase(&1) |> String.contains?("beme"))
  end

  # Remove all usernames from the tweet text
  defp map_tweet_text(chunk) do
    if String.starts_with?(chunk, "@") do
      ""
    else
      chunk
    end
  end

  # Insert the tweet ID into the DETS store
  defp insert_id(id) do
    :dets.insert(:replied_to, {id, self})
  end

  # Check if the tweet has been replied to by checking the DETS store
  defp replied_to?(id) do
    case :dets.lookup(:replied_to, id) do
      [{_, _}] -> true
      [] -> false
    end
  end

  # Open the DETS store or create one if one does not exist
  def init() do
    :dets.open_file(:replied_to, [type: :set])
  end

  # Close the DETS store
  def close() do
    :dets.close(:replied_to)
  end

  # Search for tweets containing "beme" and pipe them to the processing function
  def search_and_reply(num_tweets \\ 100) do
    ExTwitter.search("beme", count: num_tweets) 
      |> Enum.each(&process_tweet/1)
  end
end
