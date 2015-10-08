require 'facets'

Dir.glob('CSV/B_artificial/*.csv') do |item|
  next if item == '.' or item == '..'
  
  File.rewrite(item) { |str| str.gsub(",Unknown,Unknown,Unknown,Unknown", ",Unknown,Unknown,Unknown,Unknown,Unknown")}
end
