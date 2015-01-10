require 'mechanize'

unless ARGV[0]
  puts "You must supply a website."
  puts "USAGE: ruby linkScrape.rb <url to scrape>"
  exit
end

#Initialize Mechanize
agent = WWW::Mechanize.new
#set proxy...if no proxy comment this line out
agent.set_proxy('localhost',8080)

begin
  page = agent.get(ARGV[0].strip)
    
  #look for all links on the website
  page.links.each do |l|
    if l.href.split("")[0] =='/'
      puts "#{ARGV[0]}#{l.href}"
    else
      puts l.href
    end
  end
rescue => e
  puts "An error occurred."
  puts e
  retry
end