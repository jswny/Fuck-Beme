defmodule FuckBeme do
  defp reply(%{:id => tweet_id, :user => %{:screen_name => username}, :text => tweet_text}) do
    if (String.downcase(username) |> String.contains?("beme"))  || !tweet_contains_beme(tweet_text) do
      IO.puts "Skipping reply to " <> username
    else
      if replied_to?(tweet_id) do
        IO.puts "Already replied to " <> username <> ", skipping..."
      else
        IO.puts "Replying to " <> username
        ExTwitter.update("@" <> username <> " Fuck Beme", in_reply_to_status_id: tweet_id)
        insert_id(tweet_id)
      end
    end
  end

  def tweet_contains_beme(tweet_text) do
    tweet_text
      |> String.split(" ", trim: true)
      |> Enum.map(&map_tweet_text/1)
      |> Enum.any?(&String.downcase(&1) |> String.contains?("beme"))
  end

  def map_tweet_text(chunk) do
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
      |> Enum.each(&reply/1)
  end
end
