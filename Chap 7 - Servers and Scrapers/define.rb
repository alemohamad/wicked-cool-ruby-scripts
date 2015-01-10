require "open-uri"

unless ARGV[0]
  puts "You must supply a word to define."
  puts "USAGE: ruby define.rb <word to define>"
  exit
end

word = ARGV[0].strip

#URL to search for word definition
url = "http://dictionary.reference.com/search?q=#{word}"

begin
  open(url) do |source|
    #Look for definition within source code
    source.each_line do |x|
      if x =~ /No results found/
        puts "\nPlease check your spelling, no definition was found."
        exit
      end
      #if the def was found, this regular expression will match
      if x =~ /(1\.)<\/td><td valign="top">(.*)<\/td/
        puts "\n#{$1} #{$2}"
        exit
      end
    end
    puts "Sorry, unable to find a definition."
  end
rescue => e
  puts "An error occurred, please try again."
  puts e
end