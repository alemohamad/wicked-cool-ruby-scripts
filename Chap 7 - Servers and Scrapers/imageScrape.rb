require "open-uri"
require "pathname"

unless ARGV[0]
  puts "You must supply a URL to scrape images."
  puts "USAGE: ruby imageGrabber.rb <site to scrape>"
  exit
end

url = ARGV[0].strip
begin
  #Open website, uncomment proxy line and add to open() method if using a proxy
  open(url, "User-Agent" => "Mozilla/4.0 (compatible; MSIE 5.5; Windows 98)") do |source|   #, :proxy => "http://127.0.0.1:8080"
    source.each_line do |x|
      #Get images from site
      if x =~ /<img src="(.+.[jpeg|gif])"\s+/

        name = $1.split('"').first
        name = url + name if Pathname.new(name)
        copy = name.split('/').last

        File.open(copy, 'wb') do |f|
          f.write(open(name).read)
        end
      end
    end
  end
rescue => e
  puts "An error occurred, please try again."
  puts e
end