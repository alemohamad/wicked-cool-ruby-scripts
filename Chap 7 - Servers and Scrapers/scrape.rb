require 'rio'
require 'open-uri'
require 'uri'

unless ARGV[0] and ARGV[1]
  puts "You must specify an operation and URL."
  puts "USAGE: scrape.rb [page|images|links] <http://www.some_site.com>"
  exit
end

case ARGV[0]
  #scrape the page source
when "page"
  rio(ARGV[1]) > rio("#{URI.parse(ARGV[1].strip).host}.html")
  exit
when "images"
  #Scrape the images
  begin
    open(ARGV[1].strip, "User-Agent" => "Mozilla/4.0 (compatible; MSIE 5.5; Windows 98)", :proxy => "http://127.0.0.1:8080") do |source|
      source.each_line do |x|      
        #trigger on file extension
        if x =~ /.+<img src="(.+.[jpegifng])"\s+.+/
          puts x[$1]
          name = x[$1]
          if name.split("")[0] == "/"
            File.open(File.basename(name), 'w+b') do |f|
              f.write(open(ARGV[0] + name).read)
            end
          else
            File.open(File.basename(name), 'w+b') do |f|
              f.write(open(name).read)
            end
          end
        end
      end
    end
  rescue => e
    puts "An error occured, please try again."
    puts e
  end
  exit
  #Scrape links on website
when "links"
  links = File.open("links.txt","w+b")
  begin
    open(ARGV[1], "User-Agent" => "Mozilla/4.0 (compatible; MSIE 5.5; Windows 98)") do |source|
      links.puts URI.extract(source, ['http', 'https'])
    end
  rescue => e
    puts "An error occurred, please try again."
    puts e
  end
  links.close
  exit
else
  puts "You entered an invalid instruction, please try again."
  puts "USAGE: scrape.rb [page|images|links] <http://www.some_site.com>"
  exit    
end
        