unless ARGV[0]
  puts "\nYou need to include a file to test."
  puts "Usage: ruby word_freq.rb fileTest.txt"
  exit
end

unless File.exist?(ARGV[0])
  puts "\nThe file could not be found, check the path"
  puts "Usage: ruby word_freq.rb fileTest.txt"
  exit
end

file = ARGV[0]
words = Hash.new(0)
#Open the file
File.open(file, "r").each_line do |line|
  line.downcase.split.each {|i| words[i] += 1}
end

#Sort the hash by value
sorted = words.sort {|a,b| a[1]<=>b[1] }

temp = sorted.length

#10 times for the top ten sorted words
10.times do |j|
  temp -= 1
  puts "\"#{sorted[temp][0]}\" has #{sorted[temp][1]} occurrences"
end
