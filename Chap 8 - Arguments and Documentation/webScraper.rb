# == Synopsis
# 
#  web_scraper: scrape specific information from websites
# 
# 
# == Usage
# 
# web_scraper [OPTIONS] ... URL
# 
# -h, --help
#   show help
# 
# --links , -l
#    scrape all of the links off a webpage
# 
# --images, -i
#    scrape all of the images off a webpage
# 
# --page, -p
#    scrape the html code off a webpage
# 
# URL: The website that you want to scrape

require 'getoptlong'
require 'rdoc/ri/ri_paths'
require 'rdoc/usage'
require 'rio'
require 'open-uri'
require 'uri'
require 'mechanize'
require 'pathname'

#link scraper
def links(site)
  links_file = File.open("links.txt","w+b")
  agent = WWW::Mechanize.new

  begin
    page = agent.get(site.strip)
    
    #Get each link
    page.links.each do |l|
      if l.href[0..3] == "http"
        links_file.puts l.href                
      elsif (l.href.split("")[0] == '/' and site.split("").last != '/') or
          (l.href.split("")[0] != '/' and site.split("").last == '/')
        links_file.puts "#{site}#{l.href}"
      elsif l.href.split("")[0] != '/' and site.split("").last != '/'
        links_file.puts "#{site}/#{l.href}"
      else
        links_file.puts l.href
      end
    end
  rescue => e
    puts "An error occurred."
    puts e
  end
  links_file.close
end

#image scraper
def images(site)
  begin
    #connect to site
    open(site.strip, "User-Agent" => "Mozilla/4.0 (compatible; MSIE 5.5; Windows 98)") do |source|
      source.each_line do |x|        
        #look for image tags
        if x =~ /<img src="(.+.[jpeg|gif])"\s+/

          name = $1.split('"').first
          site = site + '/' unless site.split("").last == '/'
          name = site + name unless name[0..3] == "http"
          copy = name.split('/').last

          File.open(copy, 'wb') do |f|
            f.write(open(name).read)
          end
        end
      end
    end
  rescue => e
    puts "An error occurred, please try again"
    puts e
  end
end

#page source scraper
def page(site)
  rio(site) > rio("#{URI.parse(site.strip).host}.html")
end

#define all command line arguments here
opts = GetoptLong.new(
  [ '--help', '-h', GetoptLong::NO_ARGUMENT ],
  [ '--links', '-l', GetoptLong::NO_ARGUMENT ],
  [ '--images', '-i', GetoptLong::NO_ARGUMENT ],
  [ '--page', '-p', GetoptLong::NO_ARGUMENT ]
)

unless ARGV[0]
  puts "\nYou did not include a URL (try --help)"
  exit
end

url = ARGV[-1].chomp

#add command line arguments
opts.each do |opt, arg|
  case opt
  when '--help'
    RDoc::usage
  when '--links'
    links(url)
  when '--images'
    images(url)
  when '--page'
    page(url)
  else
    RDoc::usage
  end
end
