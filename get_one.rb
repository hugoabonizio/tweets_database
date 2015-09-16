require 'twitter'
require 'dotenv'
Dotenv.load

client = ::Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV['CONSUMER_KEY']
  config.consumer_secret     = ENV['CONSUMER_SECRET']
  config.access_token        = ENV['ACCESS_TOKEN']
  config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
end

client.user_timeline('cocanomc').map do |t|
  puts t.created_at.strftime("%d/%m/%Y %H:%M:%S").to_s
end