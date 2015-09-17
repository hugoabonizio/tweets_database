class Tweet
  attr_reader :text, :retweets, :timestamp
  def initialize(tweet)
    @text = filter_tweet(tweet.text)
    @retweets = tweet.retweeted_tweet? ? 0 : tweet.retweet_count
    @timestamp = tweet.created_at.strftime("%d/%m/%Y %H:%M:%S").to_s
  end
    
  private def filter_tweet(text)
    text.gsub("\n", ' ').gsub('"', '""')
  end
end