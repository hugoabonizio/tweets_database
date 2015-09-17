require 'twitter'
require 'csv'
require './tweet'

class User
  attr_accessor :username
  def initialize(username, type)
    @type = type
    @username = username
    @client = ::Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['CONSUMER_KEY']
      config.consumer_secret     = ENV['CONSUMER_SECRET']
      config.access_token        = ENV['ACCESS_TOKEN']
      config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
    end
    @tweets = []
  end
  
  def extract_tweets
    @tweets = @client.user_timeline(username, count: 200).map { |t| Tweet.new(t) }
    self
  end
  
  def save!
    unless @tweets.empty?
      ::CSV.open("CSV/#{@type}/#{@username}.csv", "w") do |csv|
        @tweets.each do |tweet|
          csv << [
            @username,
            tweet.timestamp,
            tweet.text,
            tweet.retweets,
            0.0,
            0.0,
            'Unknown',
            'Unknown',
            'Unknown',
            'Unknown'
          ]
        end
      end
    end
  end
  
  def persisted?
    File.exists? "csv/#{@type}/#{@username}.csv"
  end
end
