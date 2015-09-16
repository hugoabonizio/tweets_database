require_relative 'user'
require 'dotenv'
Dotenv.load

humans = File.read('list_humans.txt').split(',')
bots = File.read('list_bots.txt').split(',')

users = humans.map { |u| User.new(u, 'H') } + bots.map { |u| User.new(u, 'B') }
users.each do |user|
  begin
    next if user.persisted?
    sleep 0.3
    user.extract_tweets.save!
  rescue Twitter::Error::TooManyRequests => error
    puts "Chegou ao limite: #{error.rate_limit.reset_in} (#{error.rate_limit.reset_in}s)"
    sleep error.rate_limit.reset_in
  rescue Twitter::Error::Forbidden, Twitter::Error::NotFound => error
    puts "Não existe mais: #{user.username}"
  rescue Twitter::Error::Unauthorized => error
    puts "Não autorizado #{user.username}"
  end
end

puts "Humanos: #{Dir["csv/H/*"].length}"
puts "Bots: #{Dir["csv/B/*"].length}"