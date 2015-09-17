Dir.glob('CSV/H/*.csv') do |item|
  next if item == '.' or item == '..'
  
  output = ''
  
  File.open(item, 'r+') do |f|
    while line = f.gets.chomp
      output << "#{line},Unknown\n"
    end
    
  end
  
  File.open(item, 'w') { |f| f.puts output }
end
