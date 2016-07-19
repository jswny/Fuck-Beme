defmodule FuckBeme do
  defp reply(%{:id => tweet_id, :user => %{:screen_name => username}, :text => tweet_text}) do
    if (String.downcase(username) |> String.contains?("beme"))  || check_tweet_text(tweet_text) do
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

  defp check_tweet_text(tweet_text) do
    tweet_text
      |> String.split(" ", trim: true)
      |> Enum.any?(&String.starts_with?(&1, "@"))
  end

  defp insert_id(id) do
    :ets.insert(:replied_to, {id, self})
  end

  defp replied_to?(id) do
    case :ets.lookup(:replied_to, id) do
      [{_, _}] -> true
      [] -> false
    end
  end

  def init() do
    :ets.new(:replied_to, [:named_table])
  end

  def search_and_reply() do
    ExTwitter.search("beme", [count: 10]) 
      |> Enum.each(&reply/1)
  end
end
