require 'uri'
require 'open-uri'
require 'rubyful_soup'

begin
  print "\nEnter website to crawl (ex. http://www.google.com): "
  url = gets
  uri = URI.parse(url)
  html = open(uri).read
rescue Exception => e
  print "Unable to connect to the url:"
  puts "ERROR ----  #{e}"
end

soup = BeautifulSoup.new(html)

#Search the soup for any links  => href
links = soup.find_all('a').map { |a| a['href'] }

# Remove javascript and mailto: from source
links.delete_if { |href| href =~ /javascript|mailto/ }

links.each do |l|
  #Don't parse link if it is nil
  if l
    # check the links for errors
    begin
      link = URI.parse(l)
      link.scheme ||= 'http'
      link.host ||= uri.host
      link.path = uri.path + link.path unless link.path[0] == //
      link = URI.parse(link.to_s)
			
      #If the link can be read it is considered valid
      open(link).read
    rescue Exception => e
      #If the link throws an error, the script couldn't navigate to it
      #Possible reasons are 401 Forbiddens, invalid certs, or no host address
      puts "#{link} failed because #{e}"
    end
  end
end