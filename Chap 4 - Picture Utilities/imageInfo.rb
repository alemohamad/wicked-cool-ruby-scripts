require 'exifr'
include EXIFR

unless ARGV[0] and File.exists?(ARGV[0])
  puts "\n\n\nYou need to specify a filename:  ruby imageInfo.rb <filename>\n\n\n"	
  exit
end

info = JPEG.new(ARGV[0])

#Open the file and get the information avilable
File.open("info_#{File.basename(ARGV[0])}.txt", "w") do |output|
  output.puts info.exif.to_hash.map{ |k,v| "#{k}:  #{v}"}
end