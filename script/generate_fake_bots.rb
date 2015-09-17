require 'active_support/all'
require 'csv'

$dict = %w[Lorem ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua Ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur Excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum nisi ut aliquid ex ea commodi consequatur Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur vel illum qui dolorem eum fugiat quo voluptas nulla pariatur]
def random_string(size, variation = 0)
  (0...rand(size..size + variation)).map { ('a'..'z').to_a[rand(26)] }.join
end

def random_word
  $dict[rand(0...$dict.length)]
end

def random_phrase(size, variation = 0)
  (0..rand(size..size + variation)).map { |i| random_word }.join ' '
end

def raffle(string, probability)
  rand(0..probability) < probability ? string : ''
end

tweets = []

N_PHRASES = 20

phrases = (0..N_PHRASES).map do
#   "#{random_phrase(4, 5)} \##{raffle(random_string(5, 4), 50)} #{rand(1000)} \##{raffle(random_string(5, 4), 50)}"
end

last = 0

5.times do |i|
  time_between = rand(1000)
  
  username = "_bot_#{N_PHRASES}_n_#{i + 1}"
  ::CSV.open("CSV/B_artificial/#{username}.csv", "w") do |csv|
    10.times do
      ago = rand(last..last + time_between)
      timestamp = ago.minutes.ago.strftime("%d/%m/%Y %H:%M:%S").to_s
      last = ago
      
#       text = rand(100) < 50 ? "@#{random_string(7, 4)} #{phrases.sample}" : random_phrase(5, 6)
      text = "#{random_phrase(5, 6)} #{rand(1000)}"

      csv << [
        username,
        timestamp,
        text,
        0,
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