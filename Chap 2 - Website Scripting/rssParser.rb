require 'rss/1.0'
require 'rss/2.0'
require 'open-uri'

# location of rss feed
source = "http://nostarch.com/blog/?feed=rss2" 
content = "" 

open(source) do |s| 
  content = s.read 
end

#contect now contains the rss feed data
rss = RSS::Parser.parse(content, false)  

#customize how the information is presented
print "Do you want to see feed descriptions (y/n)? "  
input = gets.chomp

desc = input == 'y' || input == 'Y'

puts "\n\nTITLE: #{rss.channel.title}"
puts "DESCRIPTION: #{rss.channel.description}"
puts "LINK: #{rss.channel.link}"
puts "PUBLICATION DATE: #{rss.channel.date} \n\n"


rss.items.size.times do |i|
  puts "#{rss.items[i].date} ... #{rss.items[i].title}"
  if desc
    print "#{rss.items[i].description}\n\n\n"
  end
end
