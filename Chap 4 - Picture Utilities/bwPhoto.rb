require 'RMagick'
include Magick

unless ARGV[0]
  puts "\n\n\nYou need to specify a filename:  bwPhoto.rb <filename>\n\n\n"	
  exit
end

#Create new image name by appending bw
new_img = "bw_#{ARGV[0]}"
img = Image.read(ARGV[0]).first

#call the method to convert the image
img = img.quantize(256, GRAYColorspace)

if File.exists?(new_img)
  puts "Could not write file.  Image name already exists."
  exit
end

#Write the new black and white file to disk
img.write(new_img)