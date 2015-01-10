require 'RMagick'
include Magick


#This script will encompass Uppercase, JPG, JPEG, jpg, and jpeg
Dir['*.[Jj][Pp]*[Gg]'].each do |pic|
  image = Image.read(pic)[0]
  next if pic =~ /^th_/
  puts "Scaling down by 10% --- #{pic}"
  thumbnail = image.scale(0.10)
  if File.exists?("th_#{pic}")
    puts "Could not write file, thumbnail already exists."
    next
  end
  #Write them to a seperate folder if you wish to get organized...or you could just sort by filename
  thumbnail.write "th_#{pic}"	
end